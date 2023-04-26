// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Pausable.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Burnable.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Supply.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155URIStorage.sol";

contract ERC1155Collection is ERC1155, Ownable, ERC1155Pausable, ERC1155Burnable, ERC1155Supply, ERC1155URIStorage {

    constructor (string memory uri_) ERC1155(uri_) {}

    // ERC1155
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

    function setContractBaseURI(string memory newuri) public onlyOwner {
        _setURI(newuri);
    }

        // Optional
    function supportsInterface(
        bytes4 interfaceId) public view override(ERC1155) returns (bool)
    {
        return super.supportsInterface(interfaceId);
        
        // || interfaceId == type(ERC1155Supply).interfaceId 
        // || interfaceId == type(ERC1155URIStorage).interfaceId;
    }


    // ERC1155Pausable
    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }


    // ERC1155URIStorage
    function uri(uint256 tokenId) public view override(ERC1155, ERC1155URIStorage) returns (string memory) {
        return super.uri(tokenId);
    }

    function setTokenURI(uint256 tokenId, string memory tokenURI) public onlyOwner {
        _setURI(tokenId, tokenURI);
    }

    function setBaseURI(string memory baseURI) public onlyOwner {
        _setBaseURI(baseURI);
    }


    // ERC1155 , ERC1155Pausable, ERC1155Supply
    function _beforeTokenTransfer(
        address operator,
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) internal whenNotPaused override(ERC1155, ERC1155Pausable, ERC1155Supply) {
        super._beforeTokenTransfer(operator, from, to, ids, amounts, data);
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


A2 safeBatchTransferFrom [#3:20, #4:30, #5:40] to A3
ids:        [3,4,5]
amounts:    [20,30,40]

    A1 : 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4 : Owner of Contract
    A2 : 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2 : #1:10 , #2:20, #3:10, #4:10, #5:10
    A3 : 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db : #3:20, #4:30, #5:40

A1:owner pause the contract


A1:owner unpause the contract


A2 safeBatchTransferFrom [#1:5, #2:10] to A3
ids:        [3,4,5]
amounts:    [20,30,40]

    A1 : 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4 : Owner of Contract
    A2 : 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2 : #1:5 , #2:10, #3:10, #4:10, #5:10
    A3 : 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db : #1:5 , #2:10, #3:20, #4:30, #5:40


A3 burn #5:10

    A1 : 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4 : Owner of Contract
    A2 : 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2 : #1:5 , #2:10, #3:10, #4:10, #5:10
    A3 : 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db : #1:5 , #2:10, #3:20, #4:30, #5:30


A3 burnBatch  #3:10, #4:20, #5:20

    A1 : 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4 : Owner of Contract
    A2 : 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2 : #1:5 , #2:10, #3:10, #4:10, #5:10
    A3 : 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db : #1:5 , #2:10, #3:10, #4:10, #5:10

*/