// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

// ERC 20 Token Demo
// etherium request or comments

interface IERC20 {
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );

    function totalSupply() external view returns (uint256);

    function balanceOf(address account) external view returns (uint256);

    function transfer(address to, uint256 value) external returns (bool);

    function transferFrom(
        address from,
        address to,
        uint256 value
    ) external returns (bool);

    function allowance(address owner, address spender)
        external
        view
        returns (uint256);

    function approve(address spender, uint256 value) external returns (bool);
}

abstract contract ERC20Demo is IERC20 {
    address public founder;
    uint256 public totalSupply = 1000; // number of tokens
    mapping(address => uint256) public balanceOfUser; // user balance

    constructor() {
        founder = msg.sender;
        balanceOfUser[founder] = totalSupply;
    }

    function balanceOf(address account) external view returns (uint256) {
        return balanceOfUser[account];
    }

    function transfer(address to, uint256 value) external returns (bool) {
        require(to != address(0), "Invalid address");
        require(balanceOfUser[msg.sender] > value, "Insufficient balance");
        balanceOfUser[msg.sender] -= value;
        balanceOfUser[to] += value;
        return true;
    }

    function transferFrom(
        address from,
        address to,
        uint256 value
    ) external returns (bool) {
        require(to != address(0), "Invalid address");
        require(balanceOfUser[msg.sender] > value, "Insufficient balance");
        balanceOfUser[from] -= value;
        balanceOfUser[to] += value;
        return true;
    }
}
