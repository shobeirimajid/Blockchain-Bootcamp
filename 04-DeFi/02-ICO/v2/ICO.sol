// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import '@openzeppelin/contracts/token/ERC20/IERC20.sol';

contract ICO {

    address public admin;

    IERC20 public token;
    uint public tokenRate = 0.001 * 1e18; 	// 1e-3 * 1e18  | 1e15 wei |  10**15 wei  |  1000 MTK = 1 ETH

    uint public maxAirdropAmount = 1_000_000 * 1e18;
    uint public holderAirdropAmount = 100 * 1e18;
    uint public totalAirdrops;

    uint public icoEndTime;

    enum Stage {
        disable,    // 0    stage = Stage.disable
        airdrop,    // 1    stage = Stage.airdrop
        sale        // 2    stage = Stage.sale
    }
    Stage public stage;    // if(stage == Stage.airdrop) ==> airdrop()
   

    uint public holdersCount;   // airdrop/sale

    mapping(address => uint) private airdrops;
    mapping(address => uint) private holders;
    mapping(address => bool) private isHolder;

    event Buy(address indexed Buyer, uint indexed amount);
    event Airdrop(address indexed Receiver, uint indexed amount);

    constructor(address _token, address _admin) {
        token = IERC20(_token);
        admin = _admin;             // msg.sender;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "only admin can call this function");
        _;
    }

    modifier isActive() {
        require(icoEndTime > 0 && block.timestamp < icoEndTime, "ICO have been ended!");
        _;
    }

    modifier isInActive() {
        require(icoEndTime == 0, "ICO alrerady activated!");
        _;
    }

    modifier isAirdrop() {
        require(stage == Stage.airdrop, "Airdrop isn't active!");
        _;
    }

    modifier isSale() {
        require(stage == Stage.sale, "ICO Sale isn't active!");
        _;
    }

    // duration : seconds // 1 month = 30 * 24 * 60 * 60
    function active(uint duration, uint8 _stage) external onlyAdmin isInActive {
        require(duration > 0, "duration must be > 0");
        icoEndTime = block.timestamp + duration;
        stage = Stage(_stage);
    }

    function deActive() external onlyAdmin isActive {
        icoEndTime = 0;
        stage = Stage.disable;
    }

    function airdrop(address receiver) external isActive isAirdrop {

        // check the receiver do not have received an airdrop already
        require(airdrops[receiver] == 0, 
        "airdrop: Already done!");

        // total released airdrops should not exceed the maxAirdropAmount
        require(totalAirdrops + holderAirdropAmount <= maxAirdropAmount,
        "airdrop: All Aridrop_Tokens were released!");

        // check the token balance of this contract
        require(balanceOfTokens(address(this)) >= holderAirdropAmount, 
        "airdrop: No enough tokens for airdrop!");

        // send airdrop tokens to the receiver
        token.transfer(receiver, holderAirdropAmount);

        // update the released airdrops
        airdrops[receiver] = holderAirdropAmount;

        totalAirdrops += holderAirdropAmount;


        // if msg.sender doesn't added to the holders already
        if(!isHolder[receiver]) {

            // add msg.sender to the holders
            isHolder[receiver] = true;

            // increment number of holders
            holdersCount++;
        }

        // update the tokens that holds by the msg.sender
        holders[receiver] += holderAirdropAmount;

        emit Airdrop(receiver, holderAirdropAmount);
    }

    // caller: msg.sender
    function purchase(uint amount) external payable isActive isSale {
                                
        require(msg.value == (amount * tokenRate) / 1e18,
        "purchase: Not Correct Value!");

        // caller: ICO
        token.transfer(msg.sender, amount);

        // if msg.sender doesn't added to the holders already 
        if(!isHolder[msg.sender]) {

            // add msg.sender to the holders
            isHolder[msg.sender] = true;

            // increment number of holders
            holdersCount++;
        }

        // update the tokens that holds by the msg.sender
        holders[msg.sender] += amount;

        emit Buy(msg.sender, amount);
    }

	//------------------------
    // admin functions
	//------------------------
	
    function depositTokens(uint amount) external onlyAdmin isInActive {
        /*
            call from UI
            // msg.sender = admin
            token.approve(icoAdr, amount);
        */

        // caller: ICO
        token.transferFrom(admin, address(this), amount);
    }

    // caller: admin
    function withdrawTokens(uint amount) external onlyAdmin isInActive {

        require(amount <= balanceOfTokens(address(this)), 
        "withdrawTokens: amount is higher than the balance.");

        // caller: ICO
        token.transfer(admin, amount);
    }

    function withdrawEth(uint amount) external onlyAdmin isInActive {
	
        require(amount <= balanceOfEth(address(this)), 
        "withdrawEth: amount is higher than the balance.");
		
        payable(admin).transfer(amount);
    }

    function balanceOfTokens(address account) public view returns(uint) {
        return token.balanceOf(account);
    }

    function balanceOfEth(address account) public view returns(uint) {
        return account.balance;
    }

    function changeAdmin(address newAdmin) external onlyAdmin {
        admin = newAdmin;
    }
}
