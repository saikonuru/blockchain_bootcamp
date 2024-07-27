// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract StorageDemo {
    uint256[3] public arr = [1, 2, 3];

    function StorageTest() external {
        uint256[3] storage temp = arr;
        temp[0] *= 100;
    }

    function memTest() external view {
        uint256[3] memory temp = arr;
        temp[0] *= 100;
    }

    function gerArr() external view returns (uint256[3] memory) {
        return arr;
    }
}
