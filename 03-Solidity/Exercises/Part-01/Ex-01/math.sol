// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.15;

contract Math {

    function add(uint a, uint b) public pure returns (uint) {
        return a + b;
    }

    function sub(uint a, uint b) public pure returns (uint) {
        return a - b;
    }

    function mul(uint a, uint b) public pure returns (uint) {
        return a * b;
    }

    function pow(uint a, uint b) public pure returns (uint) {
        return a ** b;
    }

    function div(uint a, uint b) public pure returns (uint) {
        return a / b;
    }

    function mod(uint a, uint b) public pure returns (uint) {
        return a % b;
    }
}