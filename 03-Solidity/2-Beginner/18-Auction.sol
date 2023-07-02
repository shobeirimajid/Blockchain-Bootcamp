// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.5 <=0.8.13;

contract Auction {

    address public owner;

    address public benecificiary;   // آدرس مالک کالا - ذینفع   

    uint public auctionStartTime;   // زمان شروع مزایده
    uint public auctionEndTime;     // زمان پایان مزایده

    uint public highestBid;         // بالاترین مبلغ پیشنهادی
    address public highestBider;    // آدرس کسی که بالاترین قیمت را پیشنهاد داده

    mapping(address => uint) pendingRefunds;    // مبالغی که باید عودت داده شود

    bool ended;                     // وضعیت اتمام مزایده

    struct Bid {
        address bider;
        uint bidPrice;
    }
    Bid[] internal bids;            // آرایه ای از استراکت ها
                                    //  [ {bider, bidPrice} , {bider, bidPrice} , ]

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == owner, "Only Owner can start the auction!");
        _;
    }

    function startAuction(address _benecificiary, uint _basePrice, uint _deadLineDur) public onlyOwner {

        benecificiary = _benecificiary;

        // در مرحله آغازین، خود فرد ذینفع با ارائه مبلغ پایه به عنوان برنده در نظر گرفته شده است
        highestBid = _basePrice;
        highestBider = _benecificiary;

        // _deadlineDur :                       بازه زمانی - seconds
        // auctionStartTime, auctionEndTime :   نقطه زمانی - timestamp       
        auctionStartTime = block.timestamp;
        auctionEndTime = auctionStartTime + _deadLineDur;
    }


    modifier isValidTime() {
        // مهلت مزایده هم اکنون به اتمام نرسیده باشد
        require(block.timestamp < auctionEndTime, "Auction Ended!");
        _;
    }


    modifier isHighestBid() {
        // رقم پیشنهادی بیشتر از بالاترین رقم اعلام شده باشد
        require(msg.value > highestBid, "Value is less than highestBid!");
        _;
    }


    // متقاضی با فراخوانی این تابع، قیمت پیشنهادی خود را به حساب کانترکت پرداخت می کند
    function bid() public payable isValidTime  isHighestBid {

        // در شروع مزایده وقتی اولین نفر موفق به شکستن قیمت پایه می شود
        // باید از واریز مبلغ به ذینفع جلوگیری شود
        if(highestBider != benecificiary)
            // مبلغ پرداختی مربوط به بالاترین پیشنهاد قبلی باید به عنوان مبلغ عودتی برای وی منظور گردد
            pendingRefunds[highestBider] += highestBid;

        // بروزرسانی بالاترین رقم پیشنهادی
        highestBid = msg.value;
        highestBider = msg.sender;

        bids.push( Bid(highestBider, highestBid) );
    }


    // افرادی که قیمت پیشنهادی آنها شکسته شده، با فراخوانی این تابع می توانند مبالغ پرداختی خود را پس بگیرند
    function refund() public returns(bool) {

        // برای عودت هزینه ها باید مزایده به اتمام رسیده باشد
        require(ended == true, "Auction dosn't ended!");
        // TODO: قرارداد مزایده باید در فاز عودت هزینه باشد

        // محاسبه مبلغی که باید به شخص عودت داده شود
        uint amount = pendingRefunds[msg.sender];

        // مبلغی که برای شخص محاسبه شده باید بزرگتر از صفر باشد
        require(amount>0, "Your refund amount is Zero!");

        // واریز مبلغ
        bool result = paySend(msg.sender, amount);
        if(result) {
            // بروزرسانی لیست مبالغ عودتی
            pendingRefunds[msg.sender] = 0;
            return true;
        } else {
            // مبلغ عودتی این شخص نباید صفر شود تا بتواند دوباره تابع را فراخوانی کرده و مبالغ عودتی خود را دریافت کند
            return false;
        }
    }


    function payToBeneficiary() public onlyOwner returns(bool) {

        // برای عودت هزینه ها باید مزایده به اتمام رسیده باشد
        require(ended == true, "Auction dosn't ended!");
        // TODO: قرارداد مزایده باید در فاز عودت هزینه باشد

        // TODO : قبلا پرداخت به ذینفع انجام نشده باشد

        // واریز مبلغ به ذینفع
        bool result = paySend(benecificiary, highestBid);
        if(result) {
            // TODO : وضعیت کانترکت باید به "تسویه شده با ذینفع" تغییر پیدا کند
            // تا پرداخت به ذینفع مجددا قابل اجرا نباشد
        }

        return result;
    }


    function endAuction() public onlyOwner {

        // اگر مهلت مزایده به اتمام رسیده باشد، فلگ اتمام را بروزرسانی میکند
        require(block.timestamp >= auctionEndTime, "Auction can't end at this time!");

        ended = true;
    }


    function getBids() public view returns(Bid[] memory) {
        return bids;
    }


    function getWinner() public view returns(address, uint) {
        return (highestBider, highestBid);
    }


    function paySend(address To, uint amount) public returns(bool) {

        require(address(this).balance >= amount, "Not Enough Balance!");

        bool result = payable(To).send(amount);

        require(result == true, "Failure in payment via send!");

        return result;
    }
}


/*
    Beneficiary:        0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
    basePrice:          1000000000000000000 wei ~ 1 ETH
    auctionDuration:    300 Seconds ~ 5 min

    0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db  -> 2 Eth -> Refund
    0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB  -> 3 Eth -> Refund
    0x617F2E2fD72FD9D5503197092aC168c91465E7f2  -> 3 Eth -> Revert/Fail
    0x17F6AD8Ef982297579C203069C1DbfFE4348c372  -> 4 Eth -> Refund 
    0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db  -> 5 Eth -> Winner
*/