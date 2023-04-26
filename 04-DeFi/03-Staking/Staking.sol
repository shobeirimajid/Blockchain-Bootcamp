// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

import '@openzeppelin/contracts/token/ERC20/ERC20.sol';
import '@openzeppelin/contracts/token/ERC20/IERC20.sol';

contract Staking {

    // توکن سپرده گذاری
    IERC20 public stakingToken;

    // توکن سوددهی
    IERC20 public rewardToken;

    // نرخ سود - پارامتر تنظیم میزان "سود به ازای هر توکن" قابل پرداخت به سپرده گذار
    uint public rewardRate = 3*10**13;

    /*
        آخرین لحظه بروزرسانی
        این متغیر قبل از انجام هر کدام از عملیات زیر باید بروزرسانی شود
            1- stake() - سپرده گذاری
            2- withdraw() - برداشت سپرده
            3- getReward() - برداشت سود
    */
    uint public lastUpdateTime;

    // "سود به ازای هر توکن" سیستم از آخرین لحظه بروزرسانی تا این لحظه
    uint public rewardPerTokenStored;

    // تعداد کل توکن های استیک شده در سیستم
    uint private _totalStakedTokens;

    // تعداد سرمایه گذارانی که حساب سپرده آنها خالی نیست
    uint public activeInvestors;


    // "سود به ازای هر توکن" سرمایه گذار از آخرین لحظه بروزرسانی تا این لحظه
    mapping(address => uint) public userRewardPerTokenPaid;

    // تعداد کل توکن های پرداخت شده به سرمایه گذار از لحظه شروع سرمایه گذاری تا این لحظه
    mapping(address => uint) public userTotalRewardPaid;

    // کل سود" پرداخت نشده سرمایه گذار از آخرین لحظه بروزرسانی تا این لحظه"
    mapping(address => uint) public rewards;

    // تعداد توکن های استیک شده سرمایه گذار
    mapping(address => uint) private _balances;

    event tokenStake(address indexed Buyer_address, uint indexed amount);
    event tokenWithdraw(address indexed Received_address, uint indexed amount);
    event rewardPaid(address indexed Received_address, uint indexed amount);

    // دریافت آدرس توکن های سپرده و سوددهی به عنوان ورودی سازنده کانترکت
    constructor(address _stakingToken, address _rewardToken) {

        // توکن سپرده گذاری
        stakingToken = IERC20(_stakingToken);

        // توکن سوددهی
        rewardToken = IERC20(_rewardToken);
    }


    //////////////////////////////////////////////////////////////////////////////////
    //                           Stake - سپرده گذاشتن                              //
    //////////////////////////////////////////////////////////////////////////////////
    
    // سپرده گذاری در سیستم توسط سرمایه گذار

    // msg.sender : Investor
    function stake(uint _amount) external updateReward(msg.sender) {
        
        // وقتی شخصی با سپرده خالی در حال سپرده گذاری باشد یعنی یک نفر به سپرده گذاران فعال اضافه می شود
        if(_balances[msg.sender] == 0)
            activeInvestors++;

        // بروزرسانی تعداد کل توکن های استیک شده
        _totalStakedTokens += _amount;

        // بروزرسانی تعداد توکن های سرمایه گذار فعلی
        _balances[msg.sender] += _amount;

        /*
            UI
            stakingToken.approve(StakingContract, _amount);
        */

        // انتقال توکن های سرمایه گذار به حساب کانترکت استیکینگ
        // msg.sender : StakingContract
        stakingToken.transferFrom(msg.sender, address(this), _amount);
    }


    modifier updateReward(address account) {

        // بروزرسانی "سود به ازای هر توکن" سیستم از آخرین لحظه بروزرسانی تا این لحظه
        rewardPerTokenStored = rewardPerToken();

        // مقدار جدید آخرین تایم بروزرسانی
        lastUpdateTime = block.timestamp;

        // "کل سود" پرداخت نشده سرمایه گذار از آخرین لحظه بروزرسانی تا این لحظه
        rewards[account] = earned(account);

        // "سود به ازای هر توکن" پرداخت شده به سرمایه گذار تا این لحظه
        userRewardPerTokenPaid[account] = rewardPerTokenStored;

        _;
    }


    // محاسبه "سود به ازای هر توکن" سیستم از آخرین لحظه بروزرسانی تا این لحظه
    function rewardPerToken() public view returns(uint) {

        if(_totalStakedTokens == 0)
            return 0;

        return rewardPerTokenStored + ( (block.timestamp - lastUpdateTime) * rewardRate * 1e18 /  _totalStakedTokens );
    }


    // کل سود پرداخت نشده سرمایه گذار از آخرین لحظه بروزرسانی تا این لحظه
    function earned(address account) public view returns(uint) {
        return ( rewards[account] + ( _balances[account] * (rewardPerToken() - userRewardPerTokenPaid[account]))/1e18 );
    }


    //////////////////////////////////////////////////////////////////////////////////
    //                          withdraw - برداشت سپرده                            //
    //////////////////////////////////////////////////////////////////////////////////

    modifier isValidInvestor(address _account, uint _amount) {
        require(_balances[_account] >= _amount, "you haven't enough staked tokens!");
        _;
    }

    // برداشت کل یا مقداری از توکن های استیک شده سرمایه گذار
    function withdraw(uint _amount) public isValidInvestor(msg.sender, _amount) updateReward(msg.sender) {
        
        // کم کردن از تعداد توکن های استیک شده در سیستم
        _totalStakedTokens -= _amount;

        // بروزرسانی تعداد توکن های استیک شده سرمایه گذار فعلی
        _balances[msg.sender] -= _amount;

        // وقتی که سپرده سرمایه گذار صفر می شود یعنی یک نفر از سپرده گذاران فعال کم میشود
        if(_balances[msg.sender] == 0)
            activeInvestors--;

        // برداشت و انتقال توکن های استیک از کانترکت استیکینگ به حساب سرمایه گذار
        stakingToken.transfer(msg.sender, _amount);
    }


    //////////////////////////////////////////////////////////////////////////////////
    //                         getReward - برداشت سود                              //
    //////////////////////////////////////////////////////////////////////////////////

    modifier isValidReward(address _account) {
        require(rewards[_account] > 0, "you haven't any reward!");
        _;
    }

    // برداشت "کل سود" پرداخت نشده سرمایه گذار تا کنون
    function getReward() public isValidReward(msg.sender) updateReward(msg.sender) {

        // "کل سود" پرداخت نشده سرمایه گذار از آخرین لحظه بروزرسانی تا این لحظه
        uint reward = rewards[msg.sender];

        // صفر کردن "کل سود" پرداخت نشده سرمایه گذار از آخرین لحظه بروزرسانی تا این لحظه
        rewards[msg.sender] = 0;

        // برداشت و انتقال توکن سوددهی به مقدار ریوارد از حساب کانترکت به حساب سرمایه گذار
        rewardToken.transfer(msg.sender, reward);

        // بروزرسانی تعدد کل توکن های پرداخت شده به سرمایه گذار از لحظه شروع سرمایه گذاری تا کنون
        userTotalRewardPaid[msg.sender] += reward;
    }


    //////////////////////////////////////////////////////////////////////////////////
    //                            Exit - بستن قرارداد                              //
    //////////////////////////////////////////////////////////////////////////////////

    function exit() external {

        // برداشت اصل سرمایه
        withdraw(_balances[msg.sender]);

        // برداشت "کل سود سرمایه گذاری" تا کنون
        getReward();
    }


    //////////////////////////////////////////////////////////////////////////////////
    //                           Other Functions                                    //
    //////////////////////////////////////////////////////////////////////////////////

    // آدرس کانترکت استیکینگ
    function getStakingAddress() public view returns(address) {
        return address(this);
    }

    // تعداد کل توکن های استیک شده سیستم
    function getTotalStakedTokens() public view returns(uint) {
        return _totalStakedTokens;
    }

    // تعداد کل توکن های استیک شده سرمایه گذار
    function getUserStakedTokens(address account) public view returns(uint) {
        return _balances[account];
    }
}


/*

    Owner:          0x5B38Da6a701c568545dCfcB03FcB875f56beddC4

    STAKINGTOKEN :  0xd9145CCE52D386f254917e481eB44e9943F39138

    REWARDTOKEN :   0xd8b934580fcE35a11B58C6D73aDeE468a2833fa8

    STAKING :       0xf8e81D47203A594245E36C48e151709F0C19fBe8



    user:           0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
    REWARDTOKEN.balanceOf(0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2) :     
    StakingToken.approve(STAKING, 3000000000000000000000000)
    staking.stake(3000000000000000000000000)

*/