// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract StructDemo {
    // Declaration
    struct Student {
        string name;
        uint rollnum;
        uint marks;
    }

    Student private s1;

    function insertStudent(
        string memory _name,
        uint _rollnum,
        uint _marks
    ) public {
        s1 = Student({name: _name, rollnum: _rollnum, marks: _marks});
    }

    function getStudent() public view returns (Student memory) {
        return s1;
    }

    function getStudentName() external view returns (string memory) {
        return s1.name;
    }
    
}
