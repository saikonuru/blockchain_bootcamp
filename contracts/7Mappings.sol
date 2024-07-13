// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;


contract MapDemo {
    
    mapping(uint => string) public studentDetails;

    function insertStudent( uint _key,string memory _value) external {

        studentDetails[_key] = _value;
    }

}