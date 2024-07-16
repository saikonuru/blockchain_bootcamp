// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract demo {
    struct USER {
        uint id;
        string name;
    }

    USER[] list;
    uint _id = 0;

    function insert(string memory name) public {
        USER memory usr = USER({id: _id, name: name});
        list.push(usr);
        _id++;
    }

    function read() public view returns (USER[] memory) {
        return list;
    }

    function find(uint id) public view returns (USER memory) {
        return list[id];
    }
}
