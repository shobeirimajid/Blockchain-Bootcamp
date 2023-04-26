// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

import '@openzeppelin/contracts/token/ERC20/ERC20.sol';

contract RewardToken is ERC20 {
    constructor() ERC20("Reward Token", "RTK") {
        _mint(msg.sender, 4_000_000 * 10**decimals());
    }
}