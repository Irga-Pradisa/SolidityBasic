// SPDX-License-Identifier: MIT

pragma solidity 0.8.24;

contract SimpleStorage {uint public data ;
    uint256 myFavoriteNumber = 1 ;

    //uint256[] listofFavoriteNumber;
    struct Person{
        uint256 favoriteNumber;
        string name;
    }

    //Dynamic Array(Infinity add)
    Person[] public listOfPeople; 
    //Static Array (Max 3 add)
    Person[3] public listOfPeople1; 

    //mapping for know how many the uint256, just input the name/string
    mapping(string => uint256) public nameToFavoriteNumber;

    function store(uint256 _favoriteNumber) public virtual {
        myFavoriteNumber = _favoriteNumber;
    }
    //view, pure
    function retrieve() public view returns (uint256){ 
        return myFavoriteNumber;
    }
    //call data (cant be modified), memory(can be modified), storage(permanent can be modified)
    function addPerson(string memory name, uint256 _favoriteNumber)public {
        listOfPeople.push(Person(_favoriteNumber, name));
        nameToFavoriteNumber[name] = _favoriteNumber; //part of mapping
    }
}

contract SimpleStorage2 {}


