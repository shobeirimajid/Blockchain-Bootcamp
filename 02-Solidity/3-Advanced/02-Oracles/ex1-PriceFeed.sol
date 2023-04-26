// SPDX-License-Identifier: MIT
pragma solidity >=0.6.2 <0.9.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract PriceFeedConsumer {

    AggregatorV3Interface internal priceFeed;

    constructor() {}

    /*
        Price Feed Aggregator address
            https://docs.chain.link/data-feeds/price-feeds/addresses/

            Goerli Aggregators: 
            ETH/USD     :   0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e - Decimals: 8   
            BTC/ETH     :   0x779877A7B0D9E8603169DdbD7836e478b4624789 - Decimals: 18
            BTC/USD     :   0xA39434A63A52E749F02807ae27335515BA4b07F7 - Decimals: 8
            EUR/USD     :   0x44390589104C9164407A0E0562a9DBe6C24A0E05 - Decimals: 8
            USDC/USD    :   0xAb5c49580294Aff77670F839ea425f5b78ab3Ae7 - Decimals: 8
            XAU/USD     :   0x7b219F57a8e9C7303204Af681e9fA69d17ef626f - Decimals: 18
    */

    function getLatestPrice(address aggregatorAddress) public view returns(int) {
        (
            /*uint80 roundID*/,
            int price,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) = AggregatorV3Interface(aggregatorAddress).latestRoundData();

        return price;
    }


    /*
        Example :
          XAU/USD - 0x7b219F57a8e9C7303204Af681e9fA69d17ef626f - 1859119999000000000000 - Decimals: 18 - 1859.119999000000000000
          ETH/USD - 0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e - 148228092614           - Decimals: 8  - 1482.28092614
    */
    function getDecimal(address aggregatorAddress) public view returns (uint8 decimals) {
        decimals = AggregatorV3Interface(aggregatorAddress).decimals();
    }

}