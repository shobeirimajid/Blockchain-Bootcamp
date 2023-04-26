// SPDX-License-Identifier: MIT
pragma solidity >=0.6.2 <0.9.0;

// Source -> Caller -> Target


/*
    delegatecall is a low level function similar to call.

    When contract "A" executes delegatecall to contract "B", 
       A's code is executed
       with B's context 

    context: storage, msg.sender, msg.value

    NOTE:   storage layout of B must be the same as A
            The name of the variable doesn’t matter, but where it is located in storage.



        A  ───────────── call() ─────────────► B  ───────────── call() ─────────────► C
    msg.sender                             msg.sender                             msg.sender 
  (userA address)                      (ContractA address)                    (ContractB address)


        A  ────────── delegatecall() ───────►  B  ────────── delegatecall() ────────► C
    msg.sender ◄─────────────────────────────  * ◄─────────────────────────────────── *
  (userA address)                        (userA address)                        (userA address)


        A  ───────────── call() ─────────────►  B  ───────── delegatecall() ────────► C
    msg.sender                              msg.sender ◄───────────────────────────── *   
  (userA address)                      (ContractA address)                   (ContractA address)         


        A  ────────── delegatecall() ───────►  B  ───────────── call() ─────────────► C
    msg.sender ◄─────────────────────────────  *                                  msg.sender 
  (userA address)                        (userA address)                      (ContractB address)



*/


contract Target {

    uint public num;
    address public sender;
    uint public value;


    function setVars(uint _num) external payable {
        num = _num;
        sender = msg.sender;
        value = msg.value;
    }
}



contract Caller {

    uint public num;
    address public sender;
    uint public value;


    address immutable targetAdr;

    constructor(address targetAdr_) {
        targetAdr = targetAdr_;
    }


    // calling the Target.setVars()
    // Source's storage is set
    // Target is not modified

    fallback(bytes calldata data) external payable returns (bytes memory) {

        (bool status, bytes memory result) = targetAdr.delegatecall(data);
        require(status, "call failed");
        return result;
    }

    receive() external payable {}
}



contract Source {

    uint public num;
    address public sender;
    uint public value;

    address immutable callerAdr;

    constructor(address callerAdr_) {
        callerAdr = callerAdr_;
    }

    function setVars(uint _num) external payable returns (bool status, bytes memory result) { 
        (status, result) = callerAdr.delegatecall(abi.encodeWithSignature("setVars(uint256)", _num));
        require(status, "delegatecall failed");
    }
}