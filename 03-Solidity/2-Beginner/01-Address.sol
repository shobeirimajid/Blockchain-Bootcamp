// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

contract Address {

    // مقدار پیش فرض یک متغیر آدرس، آدرس صفر میباشد
    // 0x0000000000000000000000000000000000000000 ~ address(0)

    address public contractAdr;
    address public ownerAdr;

    constructor() {
        // فراخوانی کننده کانستراکتور یا همان دپلوی کننده کانترکت به عنوان مالک کانترکت محسوب می شود
        ownerAdr = msg.sender;
        contractAdr = address(this);
    }

    // کاربر با فراخوانی این فانکشن می تواند مبلغی را به آدرس کانترکت ارسال کند
    function deposit() payable public {
        
        // msg.value : wei
        if(msg.value == 0)
            // وقتی تراکنشی ریورت می شود، استیت بلاکچین برمیگردد به حالت قبل از اجرای تراکنش
            revert("Your value must be grater than zero");
    }


    function getBalance(address adr) public view returns(uint) {
        //return adr.balance / 1e18;
        return adr.balance; // wei
    }

    
    function destructor() public {
        if(msg.sender == ownerAdr)
            selfdestruct(payable(ownerAdr));
        else
            revert("Only Owner can call it!");
    }
}


/*
    Owner :     0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
    Contract:   0xd8b934580fcE35a11B58C6D73aDeE468a2833fa8
*/


/*
    1e18 ~ 10^18 wei ~ 1 Eth
    1e15 ~ 10^15 wei ~ 1/000 Eth ~ 0.001 Eth
*/


/*
    هر آدرسی در بلاکچین میتواند موجودی داشته باشد
    Account/Address:
        1. Accounts     (EOA)
        2. Contracts    (CA)
*/


/*
    -------------------
        متغیرهای عددی در سالیدیتی
    -------------------
    اعداد علامت دار - signed - int
    int8 - int16 - int32 - int64 - int128 - int256
    int ~ int256
    int8 : [0 , 2^8 - 1] ~ [0 , 255]


    اعداد بدون علامت - unsigned - uint
    uint8 - uint16 - uint32 - uint64 - uint128 - uint256
    uint ~ uint256 : [0 , 2^256-1]

    تمام متغیرهایی که مقادیر مالی و موجودی حساب را نشان میدهند باید از نوع
    uint ~ uint256
*/


/*
    دو مقدار قابل خواندن داخل هر فانکشن سالیدیتی
        msg.sender : آدرس فراخوانی کننده فانکشن
        msg.value : مقداری که فراخوانی کننده تابع پرداخت کرده است
*/


/*
        if(cond1) {
            اگر شرط برقرار بود
            TODO1;
        }
        else {
            اگر شرط برقرار نبود
            TODO2;
        }



        if(cond1) {
            TODO1;
        } else if (cond2) {
            TODO2;
        } else {
            TODO3;
        }


        Conditions ~ شرط ها
            a == b : مساوی                 
            a != b : نامساوی 
            a > b  : بزرگتری
            a < b  : کوچکتری              
            a >= b : بزرگتر یا مساوی   
            a <= b : کوچکتر یا مساوی     

        
        ترکیب شرط ها
            if(cond1 && cond2 && .. ) :    دو شرط با هم درست باشند
            if(cond1 || cond2 || .. ) :    یکی از شرط های برقرار باشد
*/


/*
    0.00001 = 10^13 = 1000_00000_00000
    0.000000000000000001 = 1
*/