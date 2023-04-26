// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.22 <0.9.0;


contract SimpleContract {

    address public creator;

    constructor(address _creator) payable {
        creator = _creator;
    }

    receive() external payable {}
}


contract Factory {

    // to hold instance of new contract
    SimpleContract[] public newSCs;

    constructor() payable {}


    // Create a new contract with SimpleContract's Code 
    // execute its constructor
    // send address of Factory as its constructor's input parameter
    function create() public returns (SimpleContract newSC) {
        newSC = new SimpleContract(address(this));
        newSCs.push(newSC);
        //return newSC;
    }


    // send ether to a created contract
    function charge(address adr, uint amount) public payable {
        (bool status, ) = adr.call{value: amount}("");
        require(status, "Charge Failed");
    }


    // Same as the previous version, Also:
    //  send "value" along with the creation
    //  get "value" from the "caller"
    function createAndCharge() public payable returns (SimpleContract newSC) {
        newSC = new SimpleContract{value: msg.value}(address(this));
        newSCs.push(newSC);
    }


    // Same as the previous version, But
    //  charges the new contract by the current contract balance, Instead of get value from the caller
    //  Contract have to be charged already.
    function createAndCharge(uint amount) public payable {
        SimpleContract newSC = new SimpleContract{value: amount}(address(this));
        newSCs.push(newSC);
    }


    // return new contract's Info
    function getNewSC(uint idx) public view returns (
        address creatorAdr,
        address scAdr,
        uint balance
    ) {
        SimpleContract sc = newSCs[idx];

        creatorAdr = sc.creator();
        scAdr = address(sc);
        balance = scAdr.balance;
    }
}