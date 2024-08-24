// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;


contract Counter {
    
    uint public counter =0;
    function incrementCounter() public  {
        counter++;
    }
}