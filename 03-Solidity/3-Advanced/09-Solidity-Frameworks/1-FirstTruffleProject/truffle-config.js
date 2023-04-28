const fs = require('fs');
require('dotenv').config();
const HDWalletProvider = require('@truffle/hdwallet-provider');
const {INFURA_API_KEY, PRIVATE_KEY} = process.env;

module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",
      port: 7545,
      network_id: "*"
    },
    dashboard: {},
    sepolia: {
      provider: () => new HDWalletProvider(PRIVATE_KEY, INFURA_API_KEY),
      network_id: '11155111',
      gas: 4465030
    }
  },
  compilers: {
    solc: {
      version: "0.8.13"
    }
  }
};
