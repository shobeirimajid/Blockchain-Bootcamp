// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.0 <0.8.11;

contract AryDelete {

    uint[] myArray;

    function get() public view returns (uint[] memory) {
        return myArray;
    }

    function set(uint[] memory newArray) public {
        myArray = newArray;
    }

    function deletByIndex(uint index) public checkLengthOfArray() checkIndexIsOutOfRange(index){
        for (uint i=index; i<myArray.length-1; i++) {
            myArray[i] = myArray[i+1];
        }
        myArray.pop();
    }

    modifier checkLengthOfArray() {
         require(myArray.length > 0, "array is empty!");
        _; 
    }

    modifier checkIndexIsOutOfRange(uint index) {
        require(index < myArray.length , "index out of range!");
        _; 
    }
}