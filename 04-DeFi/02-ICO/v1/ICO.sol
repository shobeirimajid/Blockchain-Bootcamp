// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

import '@openzeppelin/contracts/token/ERC20/IERC20.sol';

contract ICO {

    address public admin;

    IERC20 public token;
    uint public tokenPrice = 10**15 wei;    // 10**15 wei = 0.001 Eth

    uint public airdropAmount = 100 * 1e18;
    uint public maxAirdropAmount = 1_000_000 * 1e18;
    uint public totalReleasedAirdrop;                       

    uint public icoEndTime;
    uint public holdersCount;

    mapping(address => uint) public airdrops;
    mapping(address => uint) public holders;
    mapping(address => bool) public isInList;

    event Buy(address indexed Buyer_address, uint indexed amount);
    event Airdrop(address indexed Received_address, uint indexed amount);


    constructor(address _token, address _admin) {
        admin = _admin;
        token = IERC20(_token);
    }


    modifier onlyAdmin() {
        require(msg.sender == admin, "only admin can call this function");
        _;
    }


    modifier icoIsInactive() {
        require(icoEndTime == 0, "ICO alrerady activated!");
        _;
    }


    modifier icoIsActive() {
        require(icoEndTime > 0 && block.timestamp < icoEndTime , "ICO have been ended!");
        _;
    }


    function activate(uint duration) external onlyAdmin icoIsInactive {
        require(duration > 0, "duration must be > 0");
        icoEndTime = block.timestamp + duration;
    }


    function deactivate() external onlyAdmin icoIsActive {
        icoEndTime = 0;
    }


    function airdrop(address receiver) external icoIsActive {

         // برای هر شخص فقط یک بار توکن ایردراپ داده می شود
         require(airdrops[receiver] == 0, "airdrop: Already done!");

        // مقدار ایردراپ های کل نباید از حداکثر مقدار مجاز بالاتر برود
        require(totalReleasedAirdrop + airdropAmount <= maxAirdropAmount, "airdrop: All Aridrop_Tokens were released!");

        // موجودی توکن های کانترکت بررسی می شود
        require(balanceOfToken(address(this)) >= airdropAmount, "airdrop: No enough tokens for airdrop!");

        // ارسال توکن های ایردراپ
        token.transfer(receiver, airdropAmount);

        // بروزرسانی اطلاعات ایردراپ های ارائه شده
        airdrops[receiver] = airdropAmount;      
        totalReleasedAirdrop += airdropAmount;

        // اگر این اکانت قبلا در لیست هولدرها ثبت نشده باشد
        if(!isInList[receiver]) {
            
            // اکانت را به لیست هولدرها اضافه میکنیم
            isInList[receiver] = true;

            // تعداد هولدرها را یک واحد افزایش میدهیم
            holdersCount++;
        }

        // بروزرسانی تعداد توکن های که توسط این اکانت هولد می شود
        holders[receiver] += airdropAmount;

        emit Airdrop(receiver, airdropAmount);
    }


    // msg.sender : holder
    function purchase(uint amount) external payable icoIsActive {
        
        require(msg.value == (amount/1e18 * tokenPrice), "purchase: Not Correct Value!");

        // msg.sender: ico
        token.transfer(msg.sender, amount);

        // اگر این اکانت قبلا در لیست هولدرها ثبت نشده باشد
        if(!isInList[msg.sender]) {
            
            // اکانت را به لیست هولدرها اضافه میکنیم
            isInList[msg.sender] = true;

            // تعداد هولدرها را یک واحد افزایش میدهیم
            holdersCount++;
        }

        // بروزرسانی تعداد توکن های که توسط این اکانت هولد می شود
        holders[msg.sender] += amount;

        emit Buy(msg.sender, amount);
    }


    // msg.sender = admin
    function depositTokens(uint amount) external onlyAdmin {

        /*
            call from UI
            msg.sender = admin
            token.approve(ico, amount);
        */

        // msg.sender = ico
        token.transferFrom(admin, address(this), amount);
    }


    // msg.sender: admin
    function withdrawTokens(uint amount) external onlyAdmin {
        require(amount <= balanceOfToken(address(this)), "withdrawTokens: amount is higher than the balance.");

        // msg.sender = ico
        token.transfer(admin, amount);
    }


    function withdrawEth(uint amount) external onlyAdmin {
        require(amount <= balanceOfEth(address(this)), "withdrawEth: amount is higher than the balance.");
        payable(admin).transfer(amount);
    }


    function balanceOfEth(address account) public view returns(uint) {
        return account.balance;
    }


    function balanceOfToken(address account) public view returns(uint) {
        return token.balanceOf(account);
    }


    function getICOAdr() public view returns(address) {
        return address(this);
    }


    function getTokenAdr() public view returns(address) {
        return address(token);
    }


    function updateAdmin(address newAdmin) external onlyAdmin {
        admin = newAdmin;
    }
}