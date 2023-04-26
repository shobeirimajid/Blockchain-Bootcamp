// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

contract MappingStruct {

    struct Bid {
        address bider;
        uint bidPrice;
    }

    // مپینگ نوع داده ای است که برای نگهداری داده های با تعداد بالا استفاده می شود
    // مپینگ مشابه آرایه است ولی خانه های آن اندیس ندارد و طول آن مشخص نیست
    // از کلید داده ها برای یافتن آنها استفاده می شود
    // مزیت اصلی آن این است که برای پیداکردن داده ها نیاز به جستجو یا پیمایش ندارد
    // کلید داده ها : سمت چپ یا ورودی مپینگ
    // mapping(key => value)
    // INPUT/KEY   =>  output/value
    // mappingName[key] = value;
    // نکته: اگر خانه از مپینگ که وجود ندارد را بخوانید، مقدار دیفالت/پیش فرض سمت راست مپینگ را برمیگرداند
    // mapping of structs
    mapping(address => uint) public bidsMap1;

    mapping(address => Bid) public bidsMap2;

    
    function setBidsMap1(address _bider, uint _bidPrice) public {
        bidsMap1[_bider] = _bidPrice;
    }

    function setBidsMap2(address _bider, uint _bidPrice) public {
        bidsMap2[_bider] = Bid(_bider, _bidPrice);
    }


    function getBidsMap1(address _bider) public view returns(uint) {
        return bidsMap1[_bider];
    }


    function getBidsMap2(address _bider) public view returns(Bid memory) {
        return bidsMap2[_bider];
    }


    function getBidsMap2_V2(address _bider) public view returns(address, uint) {
        return (bidsMap2[_bider].bider, bidsMap2[_bider].bidPrice);
    }


    function deleteMap1(address _bider) public {
        delete bidsMap1[_bider];
    }


    function deleteMap2(address _bider) public {
        delete bidsMap2[_bider];
    }
    
}

    /*
        0x5B38Da6a701c568545dCfcB03FcB875f56beddC4 -> 1000000000000000000 
        0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2 -> 2000000000000000000
        0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db -> 3000000000000000000
    */