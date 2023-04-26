// SPDX-License-Identifier: MIT
pragma solidity >=0.6.2 <0.9.0;

contract Receiver {

    mapping(address => uint) public payments;
    event Received(string handler, address sender, uint amount);

    // These functions are going to be executed via Low-Level call()
    function payment() external payable {
        payments[msg.sender] += msg.value;
        emit Received("payment()", msg.sender, msg.value);
    }


    function payAndGetBalance(string memory _message) public payable returns (uint) {
        payments[msg.sender] += msg.value;
        emit Received(_message, msg.sender, msg.value);
        return payments[msg.sender];
    }


    // receive function is executed for plain "Ether transfers" that made via 
    // .send(), .transfer() and .call() with "empty calldata" (no function is specified => msg.data is empty)

    receive() external payable {
        payments[msg.sender] += msg.value;
        emit Received("receive()", msg.sender, msg.value);
    }


    // fallback function is executed for a .call() that have a specified (but non-exixting) function name (non-empty calldata)
    //   So no other function will be match, and fallback will be executed.
    // If some Ethers also has been sent along with that call (non-empty calldata), and receive function doesn't exist, 
    //   then "payable fallback" will be executed to receiving Ethers.

    fallback() external payable {
        payments[msg.sender] += msg.value;
        emit Received("fallback()", msg.sender, msg.value);
    }
}




    /*
        If we want to send Ether to a contract with Gas-Consuming receive function (more than 2300 gas)
        or call any other Gas-Consuming function from the contract, 
        we have to use a "low-level call", instead of `send` or `transfer`.
    */




contract Sender {

    address immutable receiverAdr;

    event Response(bool status, bytes data);

    constructor(address receiver_) {
        receiverAdr = receiver_;
    }


    // forward all gas - ajustable
    // returns bool
    // call is the current recommended method to sending Ether.

    function pay_ViaCall() public payable {

        // Receiver.receive() will be executed
        (bool sent, bytes memory data) = receiverAdr.call{value: msg.value}("");

        require(sent, "Failed to send Ether");
        emit Response(sent, data);
    }



    /*
        call is a low level function to interact with other contracts.
        This is the recommended method to use when you're just sending Ether via calling the fallback function.
        However it is not the recommend way to call existing functions.
          Because:
            - Reverts are not bubbled up
            - Type checks are bypassed
            - Function existence checks are omitted

        The Best way to call an existing function is to call it directly without low-level call

        After all
            Let's imagine that Caller contract doesn't have the Target contract source code
            but know the Target contract "address" and the "function" to call
            In this case, the right way is calling via call().
    */



    // to call the payment
    function call_payment() public payable {

        // Receiver.payment() will be executed
        (bool sent, bytes memory data) = receiverAdr.call
            {value: msg.value}
            (abi.encodeWithSignature("payment()"));

        require(sent, "Failed to send Ether");
        emit Response(sent, data);
    }


    // to call the payAndGetBalance
    // payAndGetBalance has an input parameter
    function call_payAndGetBalance() public payable {

        // Receiver.payAndGetBalance() will be executed
        (bool sent, bytes memory data) = receiverAdr.call
            {value: msg.value, gas: 10_000}
            (abi.encodeWithSignature("payAndGetBalance(string)", "we are calling via call_payAndGetBalance"));

        require(sent, "Failed to send Ether");
        emit Response(sent, data);
    }


    // call the fallbacl()
    function call_fallbacl() public payable {

        // Receiver.fallbacl() will be executed
        (bool sent, bytes memory data) = receiverAdr.call
            {value: msg.value}
            (abi.encodeWithSignature("nonExistingFunction()"));

        require(sent, "Failed to send Ether");
        emit Response(sent, data);
    }
}