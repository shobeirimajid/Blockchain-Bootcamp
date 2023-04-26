// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

contract NestedMapping {

    // nested mapping
    // mapping(key1 => mapping(key2 => value) ) public mapName;
    // mapName[key1][key2] = value;
    mapping(address => mapping (address => uint) ) public approvals;


    function setApprovals(address _owner, address _spender, uint _amount) public {
        approvals[_owner][_spender] = _amount;
    }


    function getApprovals(address _owner, address _spender) public view returns(uint) {
        return approvals[_owner][_spender];
    }

}


/*
    
    0x5B38Da6a701c568545dCfcB03FcB875f56beddC4 -> 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2 -> 2000000000000000000 
    
*/