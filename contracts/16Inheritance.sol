// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract Car {
    
    uint public carId=1;
    uint public  doors=4;
    string public  brand = "BMW"; 
    
}


contract SportsCar is Car {
    
    uint public speed=200;

    function headLight() external pure returns (string memory) {
        return "Sports head light";
    }
}