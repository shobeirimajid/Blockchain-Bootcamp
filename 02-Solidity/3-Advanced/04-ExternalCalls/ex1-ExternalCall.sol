// SPDX-License-Identifier: MIT
pragma solidity >=0.6.2 <0.9.0;

contract Counter {

    uint private count;
    error InvalidCount();


    function increment() external payable {
        count++;
    }


    function getCount() external view returns (uint) {
        return count;
    }


    function getValidCount() external view returns (uint) {
        if(count > 5)
            // revert("count is greather than 5");
            revert InvalidCount();
        else
            return count;
    }
}



contract MyContract {

    function simpleExtCall(address _counter) public view returns (uint) {
        return Counter(_counter).getCount();
    }


    function extCallWithTryCatch(address _counter) public view returns (
        uint result,
        bool success,
        string memory,  // reason
        uint,           //  errorCode
        bytes memory    // lowLevelData
    ) {

        try Counter(_counter).getValidCount() returns (uint cnt) {
            return (cnt, true, "", 0, "");

        } catch Error(string memory reason) {
            // This is executed in case "revert" was called "inside getValidCount()"
            // and a reason string was provided.
            return (0, false, reason, 0, "");

        } catch Panic(uint errorCode) {
            // This is executed in case of a panic (a serious error like division by zero or overflow) 
            // The error code can be used to determine the kind of error.
            return (0, false, "", errorCode, "");

        } catch (bytes memory lowLevelData) {
            // This is executed in case revert() was occured.
            return (0, false, "", 0, lowLevelData);
        }

    }


    function customizedExtCall(address _counter) public payable {
        Counter(_counter).increment{value: msg.value, gas: 40_000}();
    }
}