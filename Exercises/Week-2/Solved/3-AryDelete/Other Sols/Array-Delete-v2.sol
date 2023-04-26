// SPDX-License-Identifier: GPL-3.0

/**
 * Author: Mr.Yasour
 */

pragma solidity >=0.7.0 <0.9.0;

contract tamorin01 {
    
    uint256[] public array01;
    uint randSeed = 0;

    // تابع برای پر کردن اولیه آرایه
    // count = طول آرایه
    // fillMaxRnd = ماکزیمم عددی که میتواند در داخل ارایه قرار گیرد
    
    function fillArray(uint8 count,uint8 fillMaxRnd) public  {
        uint256 rndNumber;
        uint8 i=0;
        
        while(i<count) {
            rndNumber = getCustomRand(fillMaxRnd);
            array01.push(rndNumber);
            i++;
        }
    }
    
    function Delete(uint i) public {
        require(array01.length > 0, "Array is Empty. Please Fill Array With fillArray()");
        
        uint256[] memory temp;
        temp=array01;
        while (i<temp.length-1) {
            temp[i] = temp[i+1];
            i++;
        }
        
        // temp.length--;
        assembly { mstore(temp, sub(mload(temp), 1)) }
        
        delete array01;
        array01 = temp;
        delete temp;
    }

    function getArray() public view returns (uint256[] memory) {
        return array01;
    }
    
    // تولید عدد تصادفی
    function getCustomRand(uint256 maxInt) private returns (uint256 randInt) {     
        randSeed++;  
        randInt = uint256(keccak256(abi.encodePacked(block.timestamp, block.difficulty,randSeed))) % (maxInt+1);
    } 
}