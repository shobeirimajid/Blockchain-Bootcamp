// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

import "./5-ContractA.sol";


contract ContractB {

    uint public initialBalanceOfA;


    function callBalanceOfA(address addressA) public {

        // ساخت آبجکت از کانترکت مورد نظر    
        ContractA a = ContractA(addressA);

        // دسترسی به توابع پابلیک کانترکت 
        initialBalanceOfA = a.getBalanceOfA();

        // دسترسی به متغیرهای پابلیک کانترکت 
        initialBalanceOfA = a.initialBalance();
    }
}


/*
    import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/IERC20.sol";

    IERC20(tokenAdr).transfer(account, amount);
*/