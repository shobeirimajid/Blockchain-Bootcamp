// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.4.16;

import "./DateTime.sol";

contract TestDateTime{
    using DateTime for uint256;

    
    function GetTimestamp() public view returns(uint256 ) {
        return block.timestamp;
    } 

    function uint2str(uint _i) internal pure returns (string memory _uintAsString) {
        if (_i == 0) {
            return "0";
        }
        uint j = _i;
        uint len;
        while (j != 0) {
            len++;
            j /= 10;
        }
        bytes memory bstr = new bytes(len);
        uint k = len - 1;
        while (_i != 0) {
            bstr[k--] = byte(uint8(48 + _i % 10));
            _i /= 10;
        }
        return string(bstr);
    }
    
    function RetMiladiDate(uint256 inpTimestamp ) public pure returns(string memory EnDate) {
        uint16 Y=inpTimestamp.getYear();
        uint8 M =inpTimestamp.getMonth ();
        uint8 D =inpTimestamp.getDay();
        EnDate = string(abi.encodePacked(uint2str(Y) ,"-", uint2str(M),"-",uint2str(D) ) );
    }
    function RetTime(uint256 inpTimestamp ) public pure returns(string memory Tm) {
        uint16 H=inpTimestamp.getHour();
        uint8 M =inpTimestamp.getMinute ();
        uint8 S =inpTimestamp.getSecond();
        Tm = string(abi.encodePacked(uint2str(H) ,":", uint2str(M),":",uint2str(S) ) );
    }
}