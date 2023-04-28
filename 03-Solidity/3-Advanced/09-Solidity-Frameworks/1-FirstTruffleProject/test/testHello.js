// Load compiled artifacts
const HelloBlockchain = artifacts.require("./HelloBlockchain.sol");

// Start test block
contract("HelloBlockchain", accounts => {

  it("should store the value 'Hello Blockchain'", async () => {

    const instance = await HelloBlockchain.deployed();

    // Set value of Hello World
    await instance.SendRequest("Hello Blockchain", { from: accounts[0] });

    // Get stored value
    const storedData = await instance.RequestMessage.call();

    assert.equal(storedData, "Hello Blockchain", "The value 'Hello Blockchain' was not stored");
  });
  
});
