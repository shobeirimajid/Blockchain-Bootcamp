// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

contract AryStruct {

    // استراکت به تنهایی دیتا لوکیشن محسوب نمی شود
    // مانند یک قالب است که باید پر شده و در دیتااستراکچر دیگری ذخیره شود
    // برای ذخیره استراکت ها معمولا از آرایه یا مپینگ استفاده می شود

    struct Bid {
        address bider;
        uint bidPrice;
    }


    // array of structs
    Bid[] public bidsAry;


    function setBidsAry(address _bider, uint _bidPrice) public {
        bidsAry.push( Bid(_bider, _bidPrice) );
    }


    function getBidsAry(uint i) public view returns(Bid memory) {
        return bidsAry[i];
    }


    function getBidsAryV2(uint i) public view returns(address, uint) {
        return (bidsAry[i].bider , bidsAry[i].bidPrice);
    }


    function getBidsAry(address _bider) public view returns(Bid memory out) {

        for(uint i=0; i<bidsAry.length; i++) {

            if(bidsAry[i].bider == _bider) {
                out = bidsAry[i];
            }
        }
    }


    function getBid(address _bider) public view returns(uint bid) {

        for(uint i=0; i<bidsAry.length; i++) {

            if(bidsAry[i].bider == _bider) {
                bid = bidsAry[i].bidPrice;
            }
        }
    }

}

    /*
        0x5B38Da6a701c568545dCfcB03FcB875f56beddC4 -> 1000000000000000000 
        0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2 -> 2000000000000000000
        0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db -> 3000000000000000000
    */