const nft = artifacts.require("NFT");
const marketplace = artifacts.require("Marketplace");

module.exports = async function (deployer) {
  await deployer.deploy(nft, '0', '0x-----');            // mintFee = 0
  await deployer.deploy(marketplace, '2');           // feePercent = 2
};