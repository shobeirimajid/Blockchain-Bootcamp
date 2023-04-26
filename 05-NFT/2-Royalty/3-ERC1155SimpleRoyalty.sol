// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Burnable.sol";
import "@openzeppelin/contracts/token/common/ERC2981.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ERC1155SimpleRoyalty is ERC1155, ERC1155Burnable, ERC2981, Ownable {

    constructor (string memory uri) ERC1155(uri) {
        _setDefaultRoyalty(msg.sender, 1000);
    }

    // ERC1155
    function mint(
        address to,
        uint256 id,
        uint256 amount,
        bytes memory data
    ) public onlyOwner { 
        _mint(to, id, amount, data);   
    }

    function mintRoyalty(
        address to,
        uint256 id,
        uint256 amount,
        bytes memory data,
        address receiver,
        uint96 feeNumerator
    ) public onlyOwner { 
        _mint(to, id, amount, data); 
        _setTokenRoyalty(id, receiver, feeNumerator);  
    }

    function mintBatch(
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) public onlyOwner {
       _mintBatch(to, ids, amounts, data);
    }  

    function mintBatchRoyalty(
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data,
        address[] memory receivers,
        uint96[] memory feeNumerators
    ) public onlyOwner {
       _mintBatch(to, ids, amounts, data);

        for(uint256 i=0; i<ids.length; i++) {
            _setTokenRoyalty(ids[i], receivers[i], feeNumerators[i]);
        }
    } 


    function setURI(string memory newuri) public onlyOwner {
        _setURI(newuri);
    }


    //ERC1155Burnable
    function burn(address account, uint256 id, uint256 value) public override {
        super.burn(account, id, value);
        if(balanceOf(account, id) == 0) {
            _resetTokenRoyalty(id);
        }
    }

    function burnBatch(address account, uint256[] memory ids, uint256[] memory values) public override {
        super.burnBatch(account, ids, values);

        for(uint256 i=0; i<ids.length; i++) {
            if(balanceOf(account, ids[i]) == 0) {
                _resetTokenRoyalty(ids[i]);
            }
        }
    }


    // ERC1155, ERC2981
    function supportsInterface(bytes4 interfaceId) public view override(ERC1155, ERC2981) returns (bool) {
        return super.supportsInterface(interfaceId);
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

    A1 : 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
    A2 : 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
    A3 : 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db
*/