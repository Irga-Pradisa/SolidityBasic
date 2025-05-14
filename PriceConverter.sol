// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter {

    function getPrice() internal  view returns(uint256){
        //Address 0x694AA1769357215DE4FAC081bf1f309aDC325306
        //ABI 
        AggregatorV3Interface priceFeed = AggregatorV3Interface (0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (,int256 price,,,) = priceFeed. latestRoundData();
        return uint256 (price * 10**18);
    }
    function getConversionRate(uint256 ethAmount) internal view returns (uint256){  // get the price of eth{}
        uint256 ethPrice = getPrice(); //get price from the feed 
        uint256 ethAmountInUsd = (ethAmount * ethPrice) / 1e18;//convert ETH to USD and return the amount
         return ethAmountInUsd;
    }

    function getVersion() internal  view returns (uint256) {
        return AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306). version();
    }

}
