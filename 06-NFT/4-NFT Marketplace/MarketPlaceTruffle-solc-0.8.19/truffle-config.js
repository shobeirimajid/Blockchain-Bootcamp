module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",
      port: 7545,
      network_id: "*"
    },
    doshboard: {
      networkCheckTimeout: 120000,
    }
  },

  compilers: {
    solc: {
      version: "^0.8.19"
    }
    //evmVersion: "byzantium"
  },
  dashboard: {
    port: 24012,
    host: "localhost"
  }
};