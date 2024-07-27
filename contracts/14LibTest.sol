// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "contracts/13LibraryTest.sol";

contract Calc {
    function Add(uint256 a, uint256 b) external pure returns (uint256) {
        return MathLib.add(a, b);
    }
}
