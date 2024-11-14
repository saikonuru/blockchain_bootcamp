// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract StoreString {


    function storeStr() public pure returns (string memory) {
       string memory someString ="hello";
       return someString;
    }

    
}