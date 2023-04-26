// SPDX-License-Identifier: MIT
pragma solidity >=0.6.2 <0.9.0;

// Source -> Caller -> Target


contract Target {

    uint public count;


    function get() external view returns (uint) {
        return count;
    }


    function inc() external returns (uint) {
        return ++count;
    }
}



contract Caller {

    address immutable targetAdr;

    event NewCallRequest(address indexed Source, bytes data);


    constructor(address targetAdr_) {
        targetAdr = targetAdr_;
    }


    fallback(bytes calldata data) external payable returns (bytes memory) {

        (bool sent, bytes memory res) = targetAdr.call(data);
        require(sent, "call failed");

        emit NewCallRequest(msg.sender, data);

        return res;
    }
}



contract Source {

    address immutable callerAdr;

    event Log(bytes newCounterCalled);


    constructor(address callerAdr_) {
        callerAdr = callerAdr_;
    }


    // calling the Caller.fallbacl()
    function callFallback(bytes calldata data) external {
        
        (bool sent, bytes memory res) = callerAdr.call(data);
        require(sent, "call failed");

        emit Log(res);
    }


    function getTestData() external pure returns (bytes memory) {
        return abi.encodeWithSignature("inc()"); // 0x371303c0
    }
}