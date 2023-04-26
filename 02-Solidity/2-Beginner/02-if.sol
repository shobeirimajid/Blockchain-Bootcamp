// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

contract Address {


    function compare(uint num1, uint num2) public pure returns(string memory) {

        string memory result = "not compared";

        if(num1 > num2)
            result = "num1>num2";

        else 
            result = "num1<=num2"; 

        return result;
    }


    function compareV2(uint num1, uint num2) public pure returns(string memory) {

        string memory result = "not compared";

        if(num1 > num2)
            result = "num1>num2";

        else if(num1 == num2)
            result = "num1==num2";

        else
            result = "num1<=num2";

        return result;
    }

}