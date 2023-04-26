// SPDX-License-Identifier: MIT

/**
 * Author: Mr.GoliPour
 */

pragma solidity >=0.7.0 <0.9.0;

contract ArraySampleDelete {
    uint256[] public ary2 = [1, 2, 3, 4];

    //نمایش  داده های ary2
    function getArray2() public view returns (uint256[] memory) {
        return ary2;
    }

    // Delete an element with given index
    function replaceArray2Element(uint8 idx) public returns (uint256[] memory) {
        if (ary2.length <= idx) 
            revert("index is out of range! Please enter an idx between '0' and 'length-1'.");

        for (uint256 i = idx; i < ary2.length - 1; i++) {
            ary2[i] = ary2[i + 1];
        }
        
        ary2.pop();
        return ary2;
    }
}