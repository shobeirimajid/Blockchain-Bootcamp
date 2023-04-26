// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "./DateTimeContract.sol";

contract DateTimeTest {

    function Calculatedate(uint timestamp, address addr) public pure returns (uint16 , string memory, uint) {
        
        DateTimeContract dt = DateTimeContract(addr);
        
        string[12] memory Month = ["Jan","Feb","Mar","Apr","May","June","july","Aug","Sept","Oct","Nov","Des"];
        uint16 year = dt.getYear(timestamp);
		string memory month = Month[dt.getMonth(timestamp)-1];
        uint8 day = dt.getDay(timestamp);
        
        return (year, month, day);
    }
        
    function CalculateTime(uint timestamp, address addr) public pure returns (uint8 , uint8 ,uint8) {
        
        DateTimeContract dt = DateTimeContract(addr);
        
        uint8 Hour = dt.getHour(timestamp);
        uint8 Minute = dt.getMinute(timestamp);
        uint8 Second = dt.getSecond(timestamp);
        return (Hour,Minute,Second);
    }
}