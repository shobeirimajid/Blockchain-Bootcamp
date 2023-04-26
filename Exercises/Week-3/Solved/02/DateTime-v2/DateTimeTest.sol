// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "./DateTimeLibrary.sol";

contract DateTimeTest {
    
    function getDate() public view returns (uint[3] memory dt) {
        DateTimeLibrary._DateTime memory dtnow;
        dtnow = DateTimeLibrary.parseTimestamp(block.timestamp);
        dt[0] = dtnow.year;
        dt[1] = dtnow.month;
        dt[2] = dtnow.day;
        return dt;
    }
        
    function getTime() public view returns (uint[3]  memory dt) {
        DateTimeLibrary._DateTime memory dtnow;
        dtnow = DateTimeLibrary.parseTimestamp(block.timestamp);
        dt[0] = dtnow.hour;
        dt[1] = dtnow.minute;
        dt[2] = dtnow.second;
        return dt;
    }
}