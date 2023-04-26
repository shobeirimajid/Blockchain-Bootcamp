// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

contract Awake {

    address public owner;

    uint public immutable tourCost = 1e18;

    struct Member {
        bool isMember;      // عضویت
        bool isAwake;       // قطعی کردن
        bool isCancel;      // کنسل کردن
        bool isPaid;        // تسویه کردن 
    }

    mapping(address => Member) memberList;

    uint memberCount;   // تعداد اعضا
    uint awakeCount;    // تعداد نفرات قطعی شده
    uint share;         // سهم هر نفر   

    constructor() {
        owner = msg.sender;
    }


    // هر شخصی برای ثبت نام باید این تابع را فراخوانی کرده و حق ثبت نام را نیز پرداخت کند
    function register() public payable {

        // TODO: check the State of Contract
        // تور باید در مرحله ثبت نام باشد

        // هزینه ثبت نام باید یک اتر باشد
        require(msg.value == tourCost,  "Value Not equal 1 Eth");  // 10**18 ~ 1e18 ~ 1 Eth

        // شخص قبلا نباید ثبت نام کرده باشد
        require(memberList[msg.sender].isMember == false, "Already Registered!");

        // ثبت نام
        memberList[msg.sender].isMember = true;

        // بروزرسانی تعداد ثبت نام ها
        memberCount++;  // memberCount = memberCount + 1;
    }


    // اعضا باید پس از ثبت نام، با فراخوانی این تابع حضور خودشان را قطعی کنند
    function awake() public {
        
        // TODO: check the State of Contract
        // تور باید در مرحله اعلام قطعیت/کنسلی باشد

        // شخص قبلا باید ثبت نام کرده باشد
        require(memberList[msg.sender].isMember == true, "You Dont Registered!");

        // قطعی کردن
        memberList[msg.sender].isAwake = true;

        // بروزرسانی تعداد نفرات قطعی شده
        awakeCount++;
    }


    function cancel() public {

        // TODO: check the State of Contract
        // تور باید در مرحله اعلام قطعیت/کنسلی باشد

        // شخص قبلا باید ثبت نام کرده باشد
        require(memberList[msg.sender].isMember == true, "You Dont Registered!");

        // ممکن است فردی اول قطعی کرده و بعدا نظرش تغییر کرده و کنسل کند
        if(memberList[msg.sender].isAwake) {
            memberList[msg.sender].isAwake = false;
            awakeCount--;
        }

        // کنسل کردن
        memberList[msg.sender].isCancel = true;

        // قبلا نباید تسویه کرده باشد
        require(memberList[msg.sender].isPaid == false, "You are Already Paid!");

        // عودت هزینه
        paySend(msg.sender, tourCost);

        // بروزرسانی وضعیت تسویه
        memberList[msg.sender].isPaid = true;
    }


    function payShare() public {
        
        // TODO: check the State of Contract
        // تور باید در مرحله پرداخت سهم باشد

        // شخص قبلا باید ثبت نام کرده باشد
        require(memberList[msg.sender].isMember == true, "You Dont Registered!");

        // شخص قبلا باید حضور خود را قطعی کرده باشد
        require(memberList[msg.sender].isAwake, "You Dont Awake!");

        // شخص قبلا نباید کنسل کرده باشد
        require(memberList[msg.sender].isCancel == false, "You already Cancel!");

        // قبلا نباید تسویه کرده باشد
        require(memberList[msg.sender].isPaid == false, "You are Already Paid!");

        // محاسبه و پرداخت سهم
        share = getBalanceContract() / awakeCount;
        paySend(msg.sender, share);

        // بروزرسانی وضعیت تسویه
        memberList[msg.sender].isPaid = true;
    }


    function paySend(address to, uint amount) public {

        // چک کردن موجودی اسمارت کانترکت
        require(address(this).balance >= amount, "Not enough balance!");

        bool result = payable(to).send(amount);

        // چک کردن درستی انجام تراکنش
        require(result == true, "Failure in payment via send!");
    }


    function getBalanceContract() public view returns (uint) {
        return address(this).balance;    // wei
    }


    function getBalanceAccount(address adr) public view returns (uint) {
        return adr.balance;   // wei
    }
}


/*
    Member1: 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
    Member2: 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
    Member3: 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db
    Member4: 0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB
    
    Member1: 1 Eth -> awake() -> شرکت کرده -> payShare()
    Member2: 1 Eth -> cancel()
    Member3: 1 Eth -> dont awake()/cancel() غیبت -> x
    Member4: 1 Eth -> awake() -> شرکت کرده -> payShare()
*/