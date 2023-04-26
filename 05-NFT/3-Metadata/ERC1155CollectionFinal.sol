// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Pausable.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Burnable.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Supply.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155URIStorage.sol";
import "@openzeppelin/contracts/token/common/ERC2981.sol";


contract ERC1155CollectionFinal is ERC1155, Ownable, ERC1155Pausable, ERC1155Burnable, ERC1155Supply, ERC1155URIStorage, ERC2981 {

    constructor () ERC1155("https://nftstorage.link/ipfs/") {
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

    function setContractBaseURI(string memory newuri) public onlyOwner {
        _setURI(newuri);
    }

        // Optional
    function supportsInterface(bytes4 interfaceId) public view override(ERC1155, ERC2981) returns (bool) {
        return super.supportsInterface(interfaceId);
    }


    // ERC1155Pausable
    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
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


    /*
        OpenSea Contract-level metadata :
        https://docs.opensea.io/docs/contract-level-metadata

        {
            "name": "OpenSea Creatures",
            "description": "OpenSea Creatures are adorable aquatic beings primarily for demonstrating what can be done using the OpenSea platform. Adopt one today to try out all the OpenSea buying, selling, and bidding feature set.",
            "image": "external-link-url/image.png",
            "external_link": "external-link-url",
            "seller_fee_basis_points": 100, # Indicates a 1% seller fee.
            "fee_recipient": "0xA97F337c39cccE66adfeCB2BF99C1DdC54C2D721" # Where seller fees will be paid to.
        }

        You can add a contractURI method to your ERC721 or ERC1155 contract that 
        returns a URL for the storefront-level metadata for your contract.
    */

    function contractURI() public pure returns (string memory) {
       return "https://nftstorage.link/ipfs/QmTTZhHscbx8tEBJ7Ahqj8Zc5ksmZd4EeZP95hTUbnz1gc?filename=opensea-contract-erc1155.json";
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