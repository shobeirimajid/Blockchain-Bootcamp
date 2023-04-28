// Load compiled artifacts
const MyToken = artifacts.require("MyToken");

// Start test block
contract("MyToken", (accounts) => {

    const acc0 = accounts[0];
    const acc1 = accounts[1];

    it('1-Token should be deployed with correct info', async () => {
        const instance = await MyToken.deployed();
        assert.equal(await instance.name(), "MyToken", "Name of Token must be 'MyToken'");
        assert.equal(await instance.symbol(), "MTK", "Symbol of Token must be 'MTK'");
        assert.equal(await instance.decimals(), 18, "decimals of Token should be 18");
    })

    it('2-should mint 1000 MTK Token to the first account', async () => {
        const instance = await MyToken.deployed();
        const amount = 1000;
        let txResult = await instance.safeMint(acc0, amount);

        assert.equal(txResult.logs[0].event, "Transfer", "Transfer event was not emitted")
        assert.equal(txResult.logs[0].args.from, '0x0000000000000000000000000000000000000000', "Token was not transferred from the zero address");
        assert.equal(txResult.logs[0].args.to, acc0, "Receiver wrong address");
        assert.equal(txResult.logs[0].args.value, amount, "amount wrong value");

        assert.equal(await instance.balanceOf(acc0), amount, "balance of acc0 should be 1000");
        assert.equal(await instance.totalSupply(), amount, "totalSupply of Token should be 1000");
    })

    it('3-should sent 200 MTK Token from the acc0 to the acc1', async () => {
        const instance = await MyToken.deployed();

        // Check the initial balances of acc0 and acc1.
        assert.equal(await instance.balanceOf.call(acc0), 1000, "");
        assert.equal(await instance.balanceOf.call(acc1), 0, "");

        // Make transaction from first account to second.
        await instance.transfer(acc1, 200, { from: acc0 });

        //Check the balances of acc0 and acc1 after transaction.
        assert.equal(await instance.balanceOf.call(acc0), 800, "Amount wasn't correctly taken from the acc0");
        assert.equal(await instance.balanceOf.call(acc1), 200, "Amount wasn't correctly sent to the acc1");
    })
})