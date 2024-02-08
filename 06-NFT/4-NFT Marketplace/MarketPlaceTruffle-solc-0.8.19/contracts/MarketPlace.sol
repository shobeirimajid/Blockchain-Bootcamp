// SPDX-License-Identifier: MIT
pragma solidity >=0.8.19;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract Marketplace is ReentrancyGuard {

    address payable public immutable feeAccount;
    uint public immutable feePercent;
    uint public offerCount;
    uint public lastIndex;

    struct Item {
        uint itemIndex;
        IERC721 nft;
        uint tokenId;
        uint price;
        address payable seller;
        bool sold;
    }

    // itemIndex => Item(itemIndex, nftAdr, tokenId, price, seller, sold)
    mapping(uint => Item) public items;

    event Offered(uint offerIndex, address indexed nft, uint tokenId, uint price, address indexed seller);
    event Bought(uint offerIndex, address indexed nft, uint tokenId, uint price, address indexed seller, address indexed buyer);

    constructor(uint _feePercent) {
        feePercent = _feePercent;
        feeAccount = payable(msg.sender);
    }


    // List
    function makeOffer(IERC721 _nft, uint _tokenId, uint _price) external nonReentrant {
        
        require(_price > 0, "Price must be greater than zero!");

        offerCount++;
        lastIndex++;

        _nft.transferFrom(msg.sender, address(this), _tokenId);

        items[lastIndex] = Item(lastIndex, _nft, _tokenId, _price, payable(msg.sender), false);

        emit Offered(lastIndex, address(_nft), _tokenId, _price, msg.sender);
    }


    // Buy
    function purchase(uint _itemIndex) external payable nonReentrant {

        Item storage item = items[_itemIndex];

        uint _totalPrice = getTotalPrice(_itemIndex);

        require(_itemIndex > 0 && _itemIndex <= lastIndex, "item doesn't exist");
        require(msg.value >= _totalPrice, "not enough ether to cover item price");
        require(!item.sold, "item already sold");

        item.nft.transferFrom(address(this), msg.sender, item.tokenId);

        item.seller.transfer(item.price);
        feeAccount.transfer(_totalPrice - item.price);
        
        item.sold = true;
        item.seller = payable(msg.sender);      // to be deleted

        emit Bought(_itemIndex, address(item.nft), item.tokenId, item.price, item.seller, msg.sender);
    }

    // Edit
    function editOffer(uint _itemIndex, uint _newPrice) public {
        items[_itemIndex].price = _newPrice;   
    }

    // unListing
    function cancelOffer(uint _itemIndex) public nonReentrant {
        items[_itemIndex].nft.transferFrom(address(this), msg.sender, items[_itemIndex].tokenId);
        delete items[_itemIndex];
        offerCount--;
    }

    // get TotalPrice = price + Fee
    function getTotalPrice(uint _itemIndex) public view returns (uint) {
        return (items[_itemIndex].price * (100 + feePercent) / 100);
    }

    // get count of unSold NFTs
    function getUnsoldNFTs() public view returns (uint count) {
        for(uint i=1; i<=lastIndex; i++)
            if (items[i].tokenId != 0 && items[i].sold == false)
                count++;
    }
}