// SPDX-License-Identifier: GPL-3.0

/**
 * @title Hello
 * @dev ContractDescription
 * @custom:dev-run-script NatSpec
 */

pragma solidity >=0.8.2 <0.9.0;

contract Hello {
    string name;

    function store_value(string memory value) public {
        name = value;
    }

    function get_block_number() external view returns (uint256) {
        //block - read only
        return block.number;
    }

    //call data- immutability
    function StringManupulation(uint256[3] calldata _arr)
        external
        pure
        returns (uint256[3] calldata)
    {
        //_arr[0] =1; // not allowed with calldata
        return _arr;
    }

    //memory - mutability - change is allowed
    function StringManupulation2(uint256[3] memory _arr)
        external
        pure
        returns (uint256[3] memory)
    {
        _arr[0] = 1; // not allowed with calldata , with memory allowd
        return _arr;
    }

    function getList() public pure returns (uint[] memory) {
        uint[] memory list ; // Initialize with a size of 10
        for (uint i = 0; i < 10; i++) {
            list[i] = i*5;
        }
        return list;
    }


}
