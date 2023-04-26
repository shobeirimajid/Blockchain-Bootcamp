// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;


contract SampleArray {
    
    uint[] ary1;
    uint[] ary2 = [1,2,3,4];
    uint[4] ary3;
    uint[4] ary4 = [1,2,3,4];
    uint[][] ary5;
    
    // ------ get ------ //
    
    function getArray1() public view returns (uint[] memory) {
        return ary1;
    }
    
    function getArray2() public view returns (uint[] memory) {
        return ary2;
    }
    
    function getArray3() public view returns (uint[4] memory) {
        return ary3;
    }
    
    function getArray4() public view returns (uint[4] memory) {
        return ary4;
    }
    
    function getArray5() public view returns (uint[][] memory) {
        return ary5;
    }
    
    // ------ Set ------ //
    
    function setArray2(uint[] memory newArray) public {
        ary2 = newArray;
    }
    
    function setArray3(uint[4] memory newArray) public {
        ary3 = newArray;
    }
    
    function setArray5(uint[][] memory newArray) public {
        ary5 = newArray;
    }
    
    // ------ Set Element ------ //
    
    function setArray2Element(uint8 i, uint newValue) public {
        ary2[i] = newValue;
    }
    
    function setArray5Element(uint8 i, uint[] memory newValue) public {
        ary5[i] = newValue;
    }
    
    // ------ Get Element ------ //
    
    function getArray1Element(uint8 i) public view returns (uint) {
        return ary1[i];
    }
    
    function getArray2Element(uint8 i) public view returns (uint) {
        return ary2[i];
    }
    
    function getArray5Element(uint8 i) public view returns (uint[] memory) {
        return ary5[i];
    }
    
    function getArray2Length() public view returns (uint) {
        return ary2.length;
    }
    
    // ------ pop ------ //
    
    function popArray2() public {
        ary2.pop();
    }
    
    function popArray4() public {
        // Member "pop" not defined for fixed-size Arrays
    }
    
    function popArray5() public {
        ary5.pop();
    }
    
    // ------ push ------ //
    
    function pushArray4(uint newValue) public {
        // Member "push" not defined for fixed-size Arrays
    }
    
    function pushArray1(uint newValue) public {
        ary1.push(newValue);
    }
    
    function pushArray2(uint newValue) public {
        ary2.push(newValue);
    }
    
    function pushArray5(uint[] memory newValue) public {
        ary5.push(newValue);
    }
    
    // ------ delete element ------ //
    
    function deleteArray2Element(uint8 idx) public {       
        // "delete ary2[idx]" deletes the item at index idx of the ary2 
        // and leaves all other elements and the length of the array untouched.
        // This especially means that it leaves a gap in the array. 
        // If you plan to remove items, a mapping is probably a better choice.      
        delete ary2[idx];
    }
    
    function deleteArray5Element(uint8 idx) public {       
        // "delete ary5[][idx]" deletes the item at index idx of the ary5 
        // and leaves all other elements and the length of the array untouched.
        // This especially means that it leaves a gap in the array. 
        // If you plan to remove items, a mapping is probably a better choice.      
        delete ary5[idx];
    }
    
    function actualDeleteArray4Element(uint8 idx) public {    
        uint256 aryLength = ary4.length;
        uint[3] memory tmpAry;
        
        uint8 j = 0;
        for(uint8 i=0; i<aryLength; i++) {
            if(i != idx) {
                tmpAry[j] = ary4[i];
                j++;
            }
        }
        
        ary4 = tmpAry;        
        // TODO: run a pop on Array, after calling this function.
        //  ary4.pop();
    }
    
    function actualDeleteArray2Element(uint8 idx) public returns (uint256 consumedGas){       
        uint256 gas1 = gasleft(); 
		
        uint256 aryLength = ary2.length;
        uint[] memory tmpAry = new uint[](aryLength-1);       
        uint8 j = 0;
        for(uint8 i=0; i<aryLength; i++) {
            if(i != idx) {
                tmpAry[j] = ary2[i];
                j++;
            }
        }       
        ary2 = tmpAry;
        
        uint256 gas2 = gasleft();
        consumedGas = gas1 - gas2;
    }
    
    function actualDeleteArray5Element(uint8 idx) public returns (uint256 consumedGas){      
        uint256 gas1 = gasleft();
        
        uint256 aryLength = ary5.length;
        uint[][] memory tmpAry = new uint[][](aryLength-1);      
        uint8 j = 0;
        for(uint8 i=0; i<aryLength; i++) {
            if(i != idx) {
                tmpAry[j] = ary5[i];
                j++;
            }
        }    
        ary5 = tmpAry;
        
        uint256 gas2 = gasleft();
        consumedGas = gas1 - gas2;
    }
}