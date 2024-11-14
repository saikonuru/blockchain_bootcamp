// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract Slots {
    // uint8 public a = 0x1e;
    // uint256 public b = 0xffe123;
    // bool public c = true;
    // string public d = "hello";

    // struct someStruct {
    //     uint256 firstValue;
    //     uint8 secondValue;
    //     bool thirdValue;
    // }

    // uint256 aa = 1234; 
    // uint256 bb = 0x123456;
    // someStruct structVar = someStruct(0x234, 5, true);

    // uint256 a = 1234;
    // uint256 b = 0x12;
    // uint8[6]c = [1,2,3,4,5,6];
    // uint256[2] d = [11,22];

    // Dynamic  Array

    uint256 a = 0x1a01; //slot 0
    uint256 b = 0x2a01; //slot 1
    uint256[] c; //slot 2 = length of c
    uint256 d = 0x5a01; //slot 3

    constructor() {
        c.push(0xb);
        c.push(0xef2134);
        c.push(0x2342);
    }

    function getArrayElementSlot(uint256 index, uint256 storedArraySlot) public pure returns (uint256) {
        uint256 arrayElementSlot = uint256(keccak256(abi.encodePacked(storedArraySlot))) + index;
        return arrayElementSlot;
    }

    function getSlotValue(uint256 slot) public view returns (bytes32) {
        bytes32 value;
        assembly {
            value := sload(slot)
        }
        return value;
    }
}

//  uint16 secondValue;
//: 0x0000000000000000000000000000000000000000000000000000000000010005
//  uint8  secondValue;
//  0x0000000000000000000000000000000000000000000000000000000000000105
