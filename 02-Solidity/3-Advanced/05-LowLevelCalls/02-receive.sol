// SPDX-License-Identifier: MIT
pragma solidity >=0.6.2 <0.9.0;

contract Receiver {

    // .send() and .transfer() forwards 2300 gas to the receiving contract.
    // This is only a very small amount that is sufficient to trigger a simple event
    // more fields inside the Event need more than forwarded gas (2300 gas)
    // and cause to fail the send and transfer function

    event Received(address, uint);

    // receive function is executed for plain "Ether transfers" that made via 
    // .send(), .transfer() and .call() with "empty calldata" 
    // (no function is specified => msg.data is empty)

    receive() external payable {
        emit Received(msg.sender, msg.value);
    }
}


contract Sender {

    address payable immutable receiverAdr;

    constructor(address payable receiver_) {
        receiverAdr = receiver_;
    }


    // 2300 gas - not ajustable
    // throws error and "failure handling" doesn't have any control to handling the error
    // no longer recommended for sending Ether.

    function pay_ViaTransfer() public payable {
        receiverAdr.transfer(msg.value);    // Receiver.receive() will be executed
    }

    
    // 2300 gas - not ajustable
    // returns bool and "failure handling" is left to the calling contract. 
    // not recommended for sending Ether.

    function pay_ViaSend() public payable {
        bool sent = receiverAdr.send(msg.value);    // Receiver.receive() will be executed
        require(sent, "Failed to send Ether");
    }
}