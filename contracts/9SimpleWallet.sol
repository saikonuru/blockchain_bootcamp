// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract SimpleWallet {
    address public owner;
    string public str;

    event Transfer(address receiver, uint256 amount);
    event Receive(address sender, uint256 amonut);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You don't have access");
        _;
    }

    /**Contract related functions**/
    function transferToContract() external payable {
        str = "Amount transferred to the contract";
    }

    function transferToUserViaContract(address payable _to, uint256 _weiAmount)
        external
        onlyOwner
    {
        require(address(this).balance >= _weiAmount, "Insufficient Balance");
        _to.transfer(_weiAmount);
        emit Transfer(_to, _weiAmount);
    }

    function withdrawFromContract(uint256 _weiAmount) external onlyOwner {
        require(address(this).balance >= _weiAmount, "Insuffficient balance");
        payable(owner).transfer(_weiAmount);
    }

    function getContractBalanceInWei() external view returns (uint256) {
        return address(this).balance;
    }

    /**User related functions**/
    function transferToUserViaMsgValue(address _to) external payable {
        require(address(this).balance >= msg.value, "Insufficient Balance");
        payable(_to).transfer(msg.value);
    }

    function receiveFromUser() external payable {
        require(msg.value > 0, "Wei Value must be greater than zero");
        payable(owner).transfer(msg.value);
    }

    function getOwnerBalanceInWei() external view returns (uint256) {
        return owner.balance;
    }

    receive() external payable {
        emit Receive(msg.sender, msg.value);
    }

    fallback() external {}
}

//Add the following features
//1.List of receivers with amount
//2.List of transfers with amount
