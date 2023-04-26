// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ERC1155Simple is ERC1155, Ownable {

    constructor (string memory uri) ERC1155(uri) {}

    function mint(
        address to,
        uint256 id,
        uint256 amount,
        bytes memory data
    ) public onlyOwner { 
        _mint(to, id, amount, data);   
    }


    function mintBatch(
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) public onlyOwner {
       _mintBatch(to, ids, amounts, data);
    }  


    function setURI(string memory newuri) public onlyOwner {
        _setURI(newuri);
    }

} 

/*

******	base uri	******
"https://raw.githubusercontent.com/anataliocs/NFT-Standards/main/metadata/opensea-contract-1155.json"
"https://raw.githubusercontent.com/anataliocs/NFT-Standards/main/metadata/InfuraNFT.json"
"https://raw.githubusercontent.com/anataliocs/NFT-Standards/main/metadata/Infura1155NFT-type{id}.json"
"https://game.example/api/item/{id}.json"

"https://game.example/api/item/"
"1.json"

A1:owner mint #1:10 for A2

    A1 : 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4 :
    A2 : 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2 : #1:10
    A3 : 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db : 


A1:owner  mintBatch [#2:20, #3:30, #4:40, #5:50] for A2
ids:        [2,3,4,5]
amounts:    [20,30,40,50]

    A1 : 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4 :
    A2 : 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2 : #1:10 , #2:20, #3:30, #4:40, #5:50
    A3 : 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db : 


A2  safeTransferFrom #3:30 to A3

    A1 : 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4 :
    A2 : 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2 : #1:10 , #2:20,     #4:40, #5:50
    A3 : 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db : #3:30


A2 approve A1 as an operator
A1:operator safeTransferFrom [#4:40, #5:50] from A2 to A3

    A1 : 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4 :
    A2 : 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2 : #1:10 , #2:20
    A3 : 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db : #3:30, #4:40, #5:50


A3 safeBatchTransferFrom [#3:10, #4:10, #5:10] to A2
ids:        [3,4,5]
amounts:    [10,10,10]

    A1 : 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4 : Owner of Contract
    A2 : 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2 : #1:10 , #2:20, #3:10, #4:10, #5:10
    A3 : 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db : #3:20, #4:30, #5:40

*/