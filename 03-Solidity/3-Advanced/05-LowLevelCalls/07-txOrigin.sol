// SPDX-License-Identifier: MIT
pragma solidity >=0.6.2 <0.9.0;


/*
    In some cases, it is important to know who sent a transaction or message to a smart contract.
    For that reason, Solidity gives us two functions – msg.sender and tx.origin.

    tx.origin refers to the EOA that created the initial transaction. 
    This global value is passed along different function calls to other contracts.

    msg.sender tells us the last instance from where a function is called. 
    This can be an EOA or a contract. 
    If an EOA sends a transaction to contract A, contract A sees the address of the EOA as msg.sender. 
    If contract A sends a message (e. g. call) to contract B, B sees contract A’s address when looking at msg.sender.


            (C)         ---- call() --->      (B)          --- call() --->        (A)
        msg.sender = EOA_C                 msg.sender = C                       msg.sender = B 
        tx.origin  = EOA_C                 tx.origin  = EOA_C                   tx.origin  = EOA_C


    NOTE: Do Not Use tx.origin for Authorization!
*/


contract A {
    address public msgSender;
    address public txOrigin;

    function setVarsC() external {
        msgSender = msg.sender;
        txOrigin = tx.origin;
    }

}


contract B {
    address public msgSender;
    address public txOrigin;

    function setVarsB(address adrA) external returns (bool status) {
        msgSender = msg.sender;
        txOrigin = tx.origin;

        (status, ) = adrA.call(abi.encodeWithSignature("setVarsC()"));
        require(status, "call failed");
    }
}


contract C {
    address public msgSender;
    address public txOrigin;

    function setVarsA(address adrA, address adrB) external returns (bool status) {
        msgSender = msg.sender;
        txOrigin = tx.origin;

        (status, ) = adrB.call(abi.encodeWithSignature("setVarsB(address)", adrA));
        require(status, "call failed");
    }
}