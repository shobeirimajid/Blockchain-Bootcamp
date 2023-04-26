// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract TimeLockedWallet {

    address public architect;
    address public owner;
    uint public createAt;
    uint public unlockDate; 

    event Received(address from, uint amount);
    event Withdraw(address to, uint amount);
    event WithdrawTokens(address tokenAdr, address to, uint amount);

    constructor(address architect_, address owner_, uint unlockDuraion_) {
        architect = architect_;
        owner = owner_;
        createAt = block.timestamp;
        unlockDate = createAt + unlockDuraion_;     // unlockDuraion_ : 1 weeks ~ 7*24*60*60
    }


    modifier onlyOwner {
        require(msg.sender == owner, "Only owner can call this!");
        _;
    }


    // keep all the Ether sent to this address
    receive() payable external {
        emit Received(msg.sender, msg.value);
    }


    // only owner can withdraw ethers after specified time
    function withdrawEthers() public onlyOwner {
        require(block.timestamp >= unlockDate, "Your wallet doesn't unlocked!");

        // send all the balance
        payable(msg.sender).transfer(address(this).balance);

        emit Withdraw (msg.sender, address(this).balance);
    }

    
    // only owner can withdraw tokens after specified time
    function withdrawTokens(address _tokenAdr) public onlyOwner {
        require(block.timestamp >= unlockDate, "Your wallet doesn't unlocked!");

        // send all the token balance
        IERC20 token = IERC20(_tokenAdr);

        uint tokenBalance = token.balanceOf(address(this));
        token.transfer(msg.sender, tokenBalance);

        emit WithdrawTokens(_tokenAdr, msg.sender, tokenBalance);
    }


    function info() public view returns (address, address, uint, uint, uint) {
        return (architect, owner, createAt, unlockDate, address(this).balance);
    }
}