// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;
//import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol';
import '@openzeppelin/contracts/token/ERC20/ERC20.sol';

contract SimpleERC20 is ERC20 {

    constructor(uint _initialSupply) ERC20("My Token", "MTK") {
        _mint(msg.sender, _initialSupply*10**decimals());
    }
}