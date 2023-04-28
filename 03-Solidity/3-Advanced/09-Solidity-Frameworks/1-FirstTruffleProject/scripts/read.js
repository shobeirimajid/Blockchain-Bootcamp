const HelloBlockchain = artifacts.require('HelloBlockchain');

module.exports = async (callback) => {
  try {
    const helloBlockchain = await HelloBlockchain.deployed();
    const result = await helloBlockchain.RequestMessage();
    console.log(result);

  } catch(err) {
    console.log('Oops: ', err.message);
  }
  callback();
};