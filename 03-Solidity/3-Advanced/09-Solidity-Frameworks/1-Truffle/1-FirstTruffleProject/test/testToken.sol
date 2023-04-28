// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.25 <0.9.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/MyToken.sol";
import "truffle/console.sol";

contract TestMyToken {

    // Truffle will send the TestMyToken 5 Ether after deploying the contract.
    uint public initialBalance = 75 ether;

    MyToken mtk;

    address owner;
    address acc0;
    address acc1;
    address acc2;

    uint acc0_InitBalance;

    function  beforeAll() public {

        acc0 = 0xa0A9F2b0b60635C75d5a935D93019e0981482B88;
        acc1 = 0xa71dcE268b90F433b019BA95c6dc67624dE917dE;
        acc2 = 0xE3a3A1396b662F7489Db4Ab07623dD9809A23cD5;

        acc0_InitBalance = acc0.balance;

        // owner of the MyToken will be this contract ( i.e. address(this) )
        owner = address(this);

        mtk = new MyToken();
    }

    function testIntialBalance() public {

        console.log("accounts[0] balance after charging contract: ", acc0_InitBalance);

        // Truffle will send the TestMyToken one Ether after deploying the contract.
        Assert.equal(address(this).balance, 75 ether , "incorrect initialBalance of TestMyToken");
        console.log("TestMyToken initialBalance", address(this).balance);
    }


    // 1-Token should be deployed with correct info
    function testTokenInfo() public {

        //MyToken mtk = MyToken(DeployedAddresses.MyToken());
        Assert.equal(mtk.name(), "MyToken", "Name of Token must be 'MyToken'");
        Assert.equal(mtk.symbol(), "MTK", "Symbol of Token must be 'MTK'");
        Assert.equal(mtk.decimals(), 18, "decimals of Token should be 18");
    }


    // 2-should mint 1000 MTK Token to the first account
    function testTokenMint() public {

        //MyToken mtk = MyToken(DeployedAddresses.MyToken());
        uint amount = 1000;

        // owner (this contract) is the owner of MyToken and is calling safeMint to mint tokens for itself
        mtk.safeMint(owner, amount);
        Assert.equal(mtk.balanceOf(owner), amount, "balance of acc0 should be 1000");
        Assert.equal(mtk.totalSupply(), amount, "totalSupply of Token should be 1000");
    }


    // 3-should sent 200 MTK Token from the owner to the acc1
    function testTokenTransfer() public {

        // Check the initial balances of owner and acc1.
        Assert.equal(mtk.balanceOf(owner), 1000, "");
        Assert.equal(mtk.balanceOf(acc1), 0, "");

        // Make transaction from address(this)/owner to acc1.
        mtk.transfer(acc1, 200);

        //Check the balances of acc0 and acc1 after transaction.
        Assert.equal(mtk.balanceOf(owner), 800, "Amount wasn't correctly taken from the acc0");
        Assert.equal(mtk.balanceOf(acc1), 200, "Amount wasn't correctly sent to the acc1");
    }

    function testFinalBalance() public {

        uint acc0_FinalBalance = acc0.balance;
        console.log("accounts[0] final ether balance: ", acc0_FinalBalance);
        console.log("Gas paid by accounts[0]: ",  75 ether - ((acc0_InitBalance + 75 ether) - acc0_FinalBalance));

        // sent Ethers by Truffle must have remained in the contract after test execution.
        Assert.equal(address(this).balance, 75 ether , "incorrect Balance of TestMyToken");
        console.log("contract final ether balance: ", address(this).balance);
    }

    function afterAll() public {

        // Send remained tokens to acc0.
        console.log("remained tokens inside the Test contract: ", mtk.balanceOf(owner));
        mtk.transfer(acc0, mtk.balanceOf(owner));
        Assert.equal(mtk.balanceOf(owner), 0, "there are tokens inside contract yet");
        console.log("remained tokens inside the Test contract: ", mtk.balanceOf(owner));

        // Send remained ethers to acc0.
        selfdestruct(payable(acc0));
    }

}

/*
Accounts:
(0) 0xa0a9f2b0b60635c75d5a935d93019e0981482b88
(1) 0xa71dce268b90f433b019ba95c6dc67624de917de
(2) 0xe3a3a1396b662f7489db4ab07623dd9809a23cd5
(3) 0x813db98387559aba658584d11024b40fb3eb61af
(4) 0x7a0862098799eca10daef70e94e65885831366d9
(5) 0x9e1fd6c39661f0618ef8b081660d649408e1572a
(6) 0xd27753a6177c4840aa78af2969a007e359f82bd7
(7) 0xb7feaa756c82860fc7abe22fa0c463f0b1866da7
(8) 0xefddf4007ca0ef61a2ceda7c68768495fbb9c2b1
(9) 0xc56c8459540cce0b8056e55e53b86ad5161750db
*/