// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.7.0;

contract SafeMath {

    function add(uint a, uint b) public pure returns (uint) {
        uint c = a + b;
        require(c >= a, "add: Addition Overflow");
        return c;
    }

    function sub(uint a, uint b) public pure returns (uint) {
        require(a >= b, "sub: A must be equal or greater than B");
        uint c = a - b;
        return c;
    }

    function mul(uint a, uint b) public pure returns (uint) {
        uint c = a * b;
        require(c/a == b, "mul: Multiplication Overflow");
        return c;
    }

    function pow(uint a, uint b) public pure returns (uint) {
        uint c = a ** b;
        if(b > 0)
            require(c >= a, "mul: Multiplication Overflow");
        return c;
    }

    function div(uint a, uint b) public pure returns (uint) {
        require(b > 0, "div: Devide by Zero Error");
        uint c = a / b;
        return c;
    }

    function mod(uint a, uint b) public pure returns (uint) {
        require(b > 0, "mod: Devide by Zero Error");
        uint c = a % b;
        return c;
    }

}