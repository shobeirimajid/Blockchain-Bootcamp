// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Pausable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Royalty.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract ERC721Collection is ERC721, ERC721Enumerable, ERC721Pausable, ERC721Burnable, ERC721URIStorage, ERC721Royalty, Ownable {

    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter;

    constructor() ERC721("My Collection", "MCL") {}


    function safeMint(address to, string memory uri) public onlyOwner returns (uint256) {
        _tokenIdCounter.increment();    // counter = 1
        uint256 tokenId = _tokenIdCounter.current();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);

        return tokenId;
    }
        
    
    // ERC721
    function _baseURI() internal pure override returns (string memory) {
        return "https://raw.githubusercontent.com/anataliocs/NFT-Standards/main/metadata/opensea-contract-721.json";
    }


    // Pausable
    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }


    // ERC721, ERC721URIStorage, ERC721Enumerable, ERC721Pausable
    function _beforeTokenTransfer(address from, address to, uint256 tokenId, uint256 batchSize) 
        internal whenNotPaused override(ERC721, ERC721Enumerable, ERC721Pausable) {
           super._beforeTokenTransfer(from, to, tokenId, batchSize);
    }

    function supportsInterface(bytes4 interfaceId) public view override(ERC721, ERC721Enumerable, ERC721Royalty) returns (bool) {
        return super.supportsInterface(interfaceId);
        
        // || interfaceId == type(IERC721).interfaceId 
        // || interfaceId == type(IERC721Metadata).interfaceId;
    }

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage, ERC721Royalty) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId) public view override(ERC721, ERC721URIStorage) returns (string memory) {
        return super.tokenURI(tokenId);
    }
}