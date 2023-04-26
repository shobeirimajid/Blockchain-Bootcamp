// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract IERC20Test {

    IERC20 token;
	
	constructor(address tokenAdr) {
		token = IERC20(tokenAdr);
	}

    function deposit(uint amount) public {
	
		// ui/client/web3
		// token.approve(IERC20TestAddress, amount);
		
		token.transferFrom(msg.sender, address(this), amount);
	}
}