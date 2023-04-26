// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

import '@openzeppelin/contracts/token/ERC20/ERC20.sol';

contract StakingToken is ERC20 {
    constructor() ERC20("Staking Token", "STK") {
        _mint(msg.sender, 6_000_000 * 10**decimals());
    }
}