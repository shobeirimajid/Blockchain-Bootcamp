// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.22 <0.9.0;

import "./TimeLockedWallet.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract WalletFactroy {

    address owner;

    // userAddress => wallets
    mapping(address => address[]) wallets;

    event Created(address wallet, address from, address to, uint creatAt, uint unlockDuration, uint amount);


    // Prevents accidental sending of ether to the factory
    receive() payable external {
        revert();
    }

    constructor() {
        owner = msg.sender;
    }


    modifier onlyOwner {
        require(msg.sender == owner, "Only owner can call this!");
        _;
    }


    function getWallets(address _user) public view returns (address[] memory) {
        return wallets[_user];
    }


    function newTimeLockedWallet(address owner_, uint unlockDuraion_, address tokenAdr) public payable returns(address wallet) {

        // create new wallet
        TimeLockedWallet tlw = new TimeLockedWallet(address(this), owner_, unlockDuraion_);
        wallet = address(tlw);

        // Add wallet to owner's wallets
        wallets[owner_].push(wallet);

        // Send ether from this transaction to the created contract.
        payable(wallet).transfer(msg.value);

        // Send 1000 tokens from this transaction to the created contract.
        IERC20 token = IERC20(tokenAdr);
        token.transfer(wallet, 1000 * 1e18);

        // Emit event.
        emit Created(wallet, msg.sender, owner_, block.timestamp, unlockDuraion_, msg.value);
    }
}