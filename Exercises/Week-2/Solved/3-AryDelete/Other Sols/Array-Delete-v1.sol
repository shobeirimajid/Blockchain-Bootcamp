// SPDX-License-Identifier: GPL-3.0

/**
 * Author: Majid Shobeiri
 */
 
pragma solidity >=0.7.0 <0.9.0;

contract SampleArray {
    
    uint256[] ary2 = [1,2,3,4];
    uint256[][] ary5 = [[1,2,3], [4,5,6], [7,8,9]];
    
    // ------ get ------ //
    
    function getArray2() public view returns (uint[] memory) {
        return ary2;
    }
    
    
    function getArray5() public view returns (uint[][] memory) {
        return ary5;
    }
    
    // ------ delete element ------ //
    
    function DelOfAry2(uint8 idx) public {
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
    }
    
    function DelOfAry5(uint8 idx) public {      
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
    }
}