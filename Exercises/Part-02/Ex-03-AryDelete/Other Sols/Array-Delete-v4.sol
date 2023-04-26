// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract ArrayOperators {
    
    uint[] public ary;

    function SetArray(uint[] memory newArray) public {
        ary = newArray;
    }
    
    function GetArray() public view returns (uint[] memory) {
        return ary;
    }

    function GetArrayElement(uint8 i) public view returns (uint) {
        return ary[i];
    }
    
    function GetArrayLength() public view returns (uint) {
        return ary.length;
    }
    
    function PopArray() public {
        ary.pop();
    }
    
    function PushArray(uint newValue) public {
        ary.push(newValue);
    }
    
    function DeleteArrayElement(uint8 idx) public {
        delete ary[idx];
    }
    
    modifier CheckValidIndex(uint8 idx, uint256 arrayLen) {
        require((idx<=arrayLen), "Invalid array index"); 
        _;  
    }
    
    function RemoveArrayElement(uint8 idx) public CheckValidIndex(idx,ary.length) {
            for(uint8 i=idx; i<ary.length-1; i++)
              ary[i]=ary[i+1];
            ary.pop();
    }
}