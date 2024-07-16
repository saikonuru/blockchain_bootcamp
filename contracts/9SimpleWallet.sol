// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract SimpleWallet {

    address public  owner;
    string public str;

    function transfer() external  payable  {

        str="Amount transfered to the Contract";

    }

}