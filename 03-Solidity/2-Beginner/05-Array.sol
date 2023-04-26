// SPDX-License-Identifier: MIT
pragma solidity 0.7.0;
pragma experimental ABIEncoderV2;

contract Array {

    // تک بعدی
    // آرایه های داینامیک 
    uint8[] ary1;                   // []
    uint8[] ary2 = [1,2,3,4];       // [1,2,3,4]

    // آرایه های با طول ثابت
    uint8[3] ary3;                  // [0,0,0]  
    uint8[3] ary4 = [1,2,3];        // [1,2,3] 


    // دو بعدی
    // آرایه های داینامیک
    uint8[][] ary5;                 // [][]

    // آرایه های با طول ثابت
    uint8[2][3] ary6;                               // [ [0,0] , [0,0] , [0,0] ]
    uint8[2][3] ary7 = [ [1,2] , [3,4] , [5,6] ];   // [ [1,2] , [3,4] , [5,6] ]


    // ------------ length ------------- //

    function getAryLen1() public view returns (uint) {
        return ary1.length;
    }

    function getAryLen2() public view returns (uint) {
        return ary2.length;
    }

    function getAryLen5() public view returns (uint) {
        return ary5.length;
    }

    function getAryLen7() public view returns (uint) {
        return ary7.length;
    }



    // ------------ get functions ------------- //

    function getAry1() public view returns (uint8[] memory) {
        return ary1;
    }

    function getAry2() public view returns (uint8[] memory) {
        return ary2;
    }

    function getAry3() public view returns (uint8[3] memory) {
        return ary3;
    }

    function getAry4() public view returns (uint8[3] memory) {
        return ary4;
    }

    function getAry5() public view returns (uint8[][] memory) {
        return ary5;
    }

    function getAry6() public view returns (uint8[2][3] memory) {
        return ary6;
    }

    function getAry7() public view returns (uint8[2][3] memory) {
        return ary7;
    }


    // ------------ get element functions ------------- //

    function getAry2Element(uint8 i) public view returns (uint8) {
        return ary2[i];
    }

    function getAry7Element(uint8 i) public view returns (uint8[2] memory) {
        return ary7[i];
    }

    function getAry7Element(uint8 i, uint8 j) public view returns (uint8) {
        return ary7[i][j];
    }


    // ------------ set functions ------------- //

    function setAry1(uint8[] memory newAry) public {
        ary1 = newAry;
    }

    function setAry5(uint8[][] memory newAry) public {
        ary5 = newAry;
    }

    function setAry6(uint8[2][3] memory newAry) public {
        ary6 = newAry;
    }


    // ------------ set element functions ------------- //

    function setAryElement1(uint8 i, uint8 newValue) public {
        ary1[i] = newValue;
    }


    function setAryElement6(uint8 i, uint8[2] memory newValue) public {
        ary6[i] = newValue;
    }


    // ------------ pop - push functions ------------- //

    function pushAry1(uint8 newValue) public {
        ary1.push(newValue);
    }

    function pushAry5(uint8[] memory newValue) public {
        ary5.push(newValue);
    }

    function popAry1() public {
        ary1.pop();
    }

    function popAry5() public {
        ary5.pop();
    }

    // ------------ delete functions ------------- //

    function deleteElementAry1(uint8 i) public {
        delete ary1[i];
    }

    function deleteElementAry5(uint8 i) public {
        delete ary5[i];
    }

}


/*
    Array functions and properties:

        ary.length;
        ary[i] = x;
        ary[i][j] = x;


        // only for dynamic arrays:

        ary.push(x);        // [1,2,3] -> [1,2,3,x]  
        ary.pop();          // [1,2,3,x] -> [1,2,3]

        // این توابع روی آرایه های با سایز ثابت قابل اجرا نیستند
        // چون هر دو تابع روی سایز آرایه تاثیر میگذارند


        // البته حذف واقعی انجام نمی شود
        // فقط مقدار خانه مورد نظر صفر میشود
        delete ary[i];

*/