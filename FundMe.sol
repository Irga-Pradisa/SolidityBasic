// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

import {PriceConverter} from "./PriceConverter.sol";

error notOwner();

contract FundMe {
    using PriceConverter for uint256;

    uint256 public myValue = 1;
    uint256 public constant minimunUSD =5e18; //constant for more efficient gas

    address [] public funders;
    mapping (address funder => uint256 amountFunded) public addressToAmountFunded;

    address public immutable owner; //immutable for more efficient gas

    constructor() { 
        owner = msg.sender;
    }

    function fund() public payable {
        require (msg.value.getConversionRate() >= minimunUSD, "Didnt send enough ETH"); //1e18 = 1 eth = 1
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    } 

    function withdraw() public {
        // for loop
        // for(/* starting index, ending index, step amount */ )
        for(uint256 funderIndex = 0 ; funderIndex < funders.length; funderIndex++) {
                address funder = funders [funderIndex]; 
                addressToAmountFunded [funder] = 0;
        }

        //Reset the array
        funders = new address [](0);
        //actually withdraw the funds

        //transfer
        // if msg.sender = address
        // if payable(msg.sender) = payable address
        payable(msg.sender).transfer(address(this).balance);

        //send
        bool sendSucces = payable(msg.sender).send(address(this).balance);
        require(sendSucces, "Failed to send eth");

        //call
        (bool callSuccess,) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed");
    }

    modifier onlyOwner() {
        //require(msg.sender == owner, "Sender is not owner!");
        if (msg.sender != owner) {revert notOwner(); } //use error function to little bit more gas
        _;
    }

    //what happens if someone sends this ETH without calling the fund function
    //use this function : receive and fall back

    receive() external payable {
        fund();
    }

    fallback() external payable { 
        fund();

    }


}
