// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

contract SafeMathTester {
    uint8 public bigNumber = 255; // Unchecked

    function add() public {
        bigNumber += 1;
    }
}
