const nft = artifacts.require("NFT");
const marketplace = artifacts.require("Marketplace");

contract("nft", accounts => {
    it("should deploy MetaCoin", async () => {
        const nftInstance = await nft.deployed('0', accounts[0]);
    });
});

contract("marketplace", accounts => {
    it("should deploy MetaCoin", async () => {
        const marketplaceInstance = await marketplace.deployed('2');
    });
});