pragma solidity 0.8.19;

contract MyContract {

    event sent(address indexed sender, address indexed receiver, uint indexed amount);

    modifier checkBalance() {

        /*if(this.balance < amount)
            revert("Error Message");*/

        require(this.balance < amount, "Error Message");
        
        _; // plsceholder ~ body of the function (ex. `withdraw`)
    }


    function withdraw() public checkBalance {

        msg.sender.transfer(amount);

        emit sent(this.address, msg.sender, amount);

        // assert(condition);
    }
}



/*
    - Error Handling
        - if(condition) revert("error message")
        - assert(condition)
        - require(condition, "error message")
        - modifier
		- try/catch


    - Testing (unit testing)
        - test with js (Truffle, mocha, chai) - unit testing
        - test with solidity (Truffle, Foundry)
        
   
    - Debugging
        - Event
        - Extension (remix, vscode, truffle, ...)
		- Debug with console.log (Truffle, Hardhat)
*/

