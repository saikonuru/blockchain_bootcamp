// SPDX-License-Identifier: GPL-3.0
// July 09
pragma solidity >=0.8.2 <0.9.0;

contract Voting {
    function GetName() public pure returns (string memory) {
        return "Sairam";
    }

    function GetAddress() public view  returns (address) {
        return msg.sender;
    }

        function GetTimeStamp() public view  returns (uint) {
        return block.timestamp;
    }

}
