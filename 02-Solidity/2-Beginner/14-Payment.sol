// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

contract Payment {

    /*
        توابع انتقال مبلغ از کانترکت به اکانت
            1- Transfer() --- این تابع هیچ مقدار برگشتی جهت بررسی صحت انجام تراکنش برگشت نمی دهد
            2- Send() --- true : Successful / false : failure
            3- Call() --- true : Successful / false : failure
    */


    // انتقال موجودی به کانترکت در لحظه دپلوی شدن
    constructor() payable {}

    // افزودن موجودی به کانترکت بعد از دپلوی شدن
    function payToContract() public payable {}


    function payTransfer(address payable to, uint amount) public {

        // چک کردن موجودی اسمارت کانترکت
        require(address(this).balance >= amount, "Not enough balance!");

        // این تابع هیچ مقدار برگشتی جهت بررسی صحت انجام تراکنش برگشت نمی دهد
        to.transfer(amount);

        // بررسی شرط هایی که ثابت کننده درستی انجام تراکنش باشد
        // assert(شرط);
    }


    function paySend(address payable to, uint amount) public {

        // چک کردن موجودی اسمارت کانترکت
        require(address(this).balance >= amount, "Not enough balance!");

        bool result = to.send(amount);

        // چک کردن درستی انجام تراکنش
        require(result == true, "Failure in payment via send!");
    }


    function payCall(address payable to, uint amount) public {

        // چک کردن موجودی اسمارت کانترکت
        require(address(this).balance >= amount, "Not enough balance!");

        (bool result, ) = to.call{value: amount}("");

        // چک کردن درستی انجام تراکنش
        require(result == true, "Failure in payment via call!");
    }


    function getBalance() public view returns(uint) {
        return address(this).balance;
    }

}


/*
    Boolean Data type:

        true / false

    bool varName;

    if(varName) {               // ~ if(varName == true)

    }
*/