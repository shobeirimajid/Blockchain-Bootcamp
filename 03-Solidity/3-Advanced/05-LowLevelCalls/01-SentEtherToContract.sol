// SPDX-License-Identifier: MIT
pragma solidity >=0.6.2 <0.9.0;


// doesn't accept sent Ethers
contract receiver {

}


contract Sender {
    
    function endow() public payable {}

    // If that execution runs out of gas or fails in any way,
    // the Ether transfer will be "reverted" and the current contract will stop with an "exception".

    function transfer(address _receiver) public {
        address payable payableReceiver = payable(_receiver);
        payableReceiver.transfer(1 ether);
    }


    function send(address _receiver) public returns (bool) {

        // address(_receiver) will not allow to call '_receiver' directly, 
        // since '_receiver' has no payable fallback function
        // It has to be converted to the 'address payable' to even allow calling 'send' on it
        address payable payableReceiver = payable(_receiver);

        
        // There is no receive function in Test contract
        // If someone sends Ether to that contract, the send will fail
        // i.e. this returns false here.
        return payableReceiver.send(1 ether);
    }


    // returns false on failure
    function call(address _receiver) public returns (bool) {
        (bool result, ) = _receiver.call{value: 1 ether}("");
        return  result;
    }
}