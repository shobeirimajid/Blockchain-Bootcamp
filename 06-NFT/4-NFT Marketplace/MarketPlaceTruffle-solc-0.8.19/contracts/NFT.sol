// SPDX-License-Identifier: MIT
pragma solidity >=0.8.19;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
//import "@openzeppelin/contracts/utils/Counters.sol";

error Need_More_Eth();

contract NFT is ERC721URIStorage, Ownable {

    //using Counters for Counters.Counter;
    //Counters.Counter private _tokenIds;
	
    uint private _nextTokenId;
    uint internal immutable mintFee;

    event NftMinted(address indexed menter, uint tokenId);

    constructor(uint _mintFee, address initialOwner) ERC721("My Collection", "MCL") Ownable(initialOwner) {
        mintFee = _mintFee;
    }

    function mintNFT(address to, string memory _tokenURI) external payable onlyOwner returns (uint) {
        
        if(msg.value < mintFee)
            revert Need_More_Eth();

        //require(msg.value >= mintFee, "Need_More_Eth");

        //_tokenIds.increment();              // default : 0  -> counter = 1
        //uint tokenId = _tokenIds.current(); // tokenId = 1

        uint tokenId = _nextTokenId++;

        _safeMint(to, tokenId);
        _setTokenURI(tokenId, _tokenURI);

        emit NftMinted(to, tokenId);
        return tokenId;
    }

    function getMintFee() public view returns (uint) {
        return mintFee;
    }

    function getTokenCounter() public view returns (uint) {
        //return  _tokenIds.current();
        return _nextTokenId;
    }
}