// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Royalty.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract ERC721SimpleRoyalty is ERC721, ERC721Burnable, ERC721URIStorage, ERC721Royalty, Ownable  {

    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter; 
    
    constructor() ERC721("My Collection", "MCL") {
        _setDefaultRoyalty(msg.sender, 1000);
    }
    
    // ERC721
    function safeMint(address to, string memory uri) public onlyOwner returns (uint256) {
        _tokenIdCounter.increment();
        uint256 tokenId = _tokenIdCounter.current();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
        return tokenId;
    }

    // feeNumerator is in basis points so  10000 = 100%  ,  1000 = 10%  ,  100 = 1%
    function safeMintRoyalty(address to, string memory uri, address receiver, uint96 feeNumerator) public onlyOwner returns (uint256) {
        uint256 tokenId = safeMint(to, uri);
        _setTokenRoyalty(tokenId, receiver, feeNumerator);
        return tokenId;
    }

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage, ERC721Royalty) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId) public view override(ERC721, ERC721URIStorage) returns (string memory) {
        return super.tokenURI(tokenId);
    }


    function _baseURI() internal view virtual override returns (string memory) {
        return "https://game.example/api/item/";
    }


    // ERC721, ERC721Royalty
    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC721, ERC721Royalty) returns (bool) {
        return super.supportsInterface(interfaceId);
    }


    // ERC-2981
    // _feeDenominator() Defaults to 10000 but may be customized by an override.
    function _feeDenominator() internal pure virtual override returns (uint96) {
        return 10000;
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