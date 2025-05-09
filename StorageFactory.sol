// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

//Import contract with another file
import {SimpleStorage, SimpleStorage2 } from "./SimpleStorage.sol";

//factory contract
contract StorageFactory{

    //uint256 public favoriteNumber
    //type visibility name
    SimpleStorage[] public listOfSImpleStorageContracts;

    function createSimpleStorageContract() public {
        SimpleStorage newSimpleStorageContract = new SimpleStorage();
        listOfSImpleStorageContracts.push(newSimpleStorageContract);
    }
    
    //function to get the address of the current contract
    function getAddress() public view returns (address) {
        return address(this);
    }

    function sfStorage(uint256 _simpleStorageIndex, uint256 _newSimpleStorageContract)public {
        listOfSImpleStorageContracts[_simpleStorageIndex].store(_newSimpleStorageContract);
    }

    function sfGet(uint256 _simpleStorageIndex)public view returns (uint256) {
        return listOfSImpleStorageContracts[_simpleStorageIndex].retrieve();
    }
}
