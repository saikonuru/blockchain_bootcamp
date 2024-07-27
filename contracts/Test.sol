// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract demo {
    struct User{
        uint id;
        string name;
    }

    User[] public users;
    uint public userCount;
    
    function insert(string memory _name) public {
        uint _id = userCount+1;
        users.push(User(_id,_name));
        userCount++;
    }

     function read(uint _id) public view returns (uint, string memory) {
        for (uint i = 0; i < users.length; i++) {
            if (users[i].id != _id) continue;
            return (users[i].id,users[i].name);
        }
        revert("User does not exist!");
    }


    function find(uint _id) public view returns (string memory) {
        for (uint i = 0; i < users.length; i++) {
            if (users[i].id != _id) continue;
            return (users[i].name);
        }
        revert("User does not exist!");
    }
}

