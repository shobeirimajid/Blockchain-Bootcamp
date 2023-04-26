// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.0;

import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol';

contract SafeMathContract {

    using SafeMath for uint256;

    function add(uint a, uint b) public pure returns (uint) {
        return a.add(b);
    }

    function sub(uint a, uint b) public pure returns (uint) {
        return a.sub(b);
    }

    function mul(uint a, uint b) public pure returns (uint) {
        return a.mul(b);
    }

    function pow(uint a, uint b) public pure returns (uint) {
        uint c = a ** b;
        if(b > 0)
            require(c >= a, "mul: Multiplication Overflow");
        return c;
    }

    function div(uint a, uint b) public pure returns (uint) {
        return a.div(b);
    }

    function mod(uint a, uint b) public pure returns (uint) {
        return a.mod(b);
    }

}