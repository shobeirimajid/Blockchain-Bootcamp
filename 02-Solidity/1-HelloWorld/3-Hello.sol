// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

contract Hello {

    string public helloStr;

    constructor() {
        helloStr = "Hello World!";
    }

    function setHello(string memory newValue) public {
        helloStr = newValue;
    }

    function getHello() public view returns(string memory) {
        return helloStr;
    }

}

// Polygon testnet
// https://mumbai.polygonscan.com/address/0x275858d90e17e63d3d5dfa023e4ab6b03343857d#code
// 0x275858d90e17e63d3d5DfA023E4ab6B03343857D