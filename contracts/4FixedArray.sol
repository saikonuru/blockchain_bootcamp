// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract FixedArrayDemo {
    uint[5] public myArray;

    function getLength() external view returns (uint) {
        return myArray.length;
    }

    function insertElement(uint _element, uint _index) external {
        myArray[_index] = _element;
    }

    function getElement(uint _index) external view returns (uint) {
        return myArray[_index];
    }

    function updateElement(uint _element, uint _index) external {
        require(_index < myArray.length, "Index out of bounds");
        myArray[_index] = _element;
    }

    function getArray() external view  returns(uint[5] memory)  {
        return  myArray;
    }
}
