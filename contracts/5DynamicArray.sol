// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract DynamicArrayDemo {
    uint256[] public myArray;

    function getLength() external view returns (uint256) {
        return myArray.length;
    }

    function insertElement(uint256 _element) external {
        myArray.push(_element);
    }

    function popElement() external  {
         myArray.pop();
    }

    function getElement(uint256 _index) external view returns (uint256) {
        return myArray[_index];
    }

    function updateElement(uint256 _element, uint256 _index) external {
        require(_index < myArray.length, "Index out of bounds");
        myArray[_index] = _element;
    }

    function getArray() external view returns (uint256[] memory) {
        return myArray;
    }
}
