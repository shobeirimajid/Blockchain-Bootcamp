// SPDX-License-Identifier: MIT
pragma solidity >=0.6.2 <0.9.0;

contract Counter {

    uint public count;

    function increment() public {
        count ++;
    }
}

interface ICounter {
    function count() external view returns (uint);
    function increment() external;
}


contract MyContract {

    function incrementCounter(address _counter) public {
        ICounter(_counter).increment();
    }

    function getCount(address _counter) public view returns (uint) {
        return ICounter(_counter).count();
    }

}