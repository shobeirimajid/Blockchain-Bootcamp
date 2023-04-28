// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.25 <0.9.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/MyToken.sol";

contract TestMyToken {

    address owner;

    constructor() {
        owner = msg.sender;
    }

    // 1-Token should be deployed with correct info
    function testTokenInfo() public {
        //MyToken mtk = MyToken(DeployedAddresses.MyToken());
        MyToken mtk = new MyToken();

        Assert.equal(mtk.name(), "MyToken", "Name of Token must be 'MyToken'");
        Assert.equal(mtk.symbol(), "MTK", "Symbol of Token must be 'MTK'");
        Assert.equal(mtk.decimals(), 18, "decimals of Token should be 18");
    }


    // 2-should mint 1000 MTK Token to the first account
    function testTokenMint() public {
        MyToken mtk = MyToken(DeployedAddresses.MyToken());
        uint amount = 1000 * 10**mtk.decimals();
        mtk.safeMint(owner, amount);

        Assert.equal(mtk.balanceOf(owner), amount, "balance of acc0 should be 1000");
        Assert.equal(mtk.totalSupply(), amount, "totalSupply of Token should be 1000");
    }

}


/*
    Truffle's Solidity testing framework was built with the following issues in mind:

        1- Solidity tests shouldn't extend from any contract (like a Test contract). 
            This makes your tests as minimal as possible and gives you complete control over the contracts you write.

        2- Solidity tests shouldn't be beholden to any assertion library. 
            Truffle provides a default assertion library for you, but you can change this library at any time to fit your needs.

        3- You should be able to run your Solidity tests against any Ethereum client.

*/