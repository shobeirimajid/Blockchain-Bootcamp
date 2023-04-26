// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.0 <0.8.11;

contract Factorial {

    function factorial(uint num) public pure returns(uint) {
        if (num == 1) {
            return num;
        } else {
            return num * factorial(num - 1);
        }
    }

}