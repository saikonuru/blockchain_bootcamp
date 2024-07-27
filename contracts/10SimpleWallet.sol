// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract SimpleWalletNew {
    address public owner;
    string public str;

    event Transfer(address receiver, uint256 amount);
    event Receive(address sender, uint256 amonut);
    event ReceiveUser(address sender, address receiver, uint256 amount);

    struct Transaction {
        address from;
        address to;
        uint256 timeStamp;
        uint256 amount;
    }

    Transaction[] public transactionHistory;

    constructor  () {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You don't have access");
        _;
    }

    /**Contract related functions**/
    function transferToContract() external payable {
        transactionHistory.push(
            Transaction({
                from: msg.sender,
                to: address(this),
                timeStamp: block.timestamp,
                amount: msg.value
            })
        );
        emit ReceiveUser(msg.sender, address(this), msg.value);
    }

    function transferToUserViaContract(address payable _to, uint256 _weiAmount)
        external
        onlyOwner
    {
        require(address(this).balance >= _weiAmount, "Insufficient Balance");
        _to.transfer(_weiAmount);
        transactionHistory.push(
            Transaction({
                from: msg.sender,
                to: _to,
                timeStamp: block.timestamp,
                amount: _weiAmount
            })
        );
        emit Transfer(_to, _weiAmount);
    }

    function withdrawFromContract(uint256 _weiAmount) external onlyOwner {
        require(address(this).balance >= _weiAmount, "Insuffficient balance");
        transactionHistory.push(
            Transaction({
                from: address(this),
                to: address(owner),
                timeStamp: block.timestamp,
                amount: _weiAmount
            })
        );
    }

    function getContractBalanceInWei() external view returns (uint256) {
        return address(this).balance;
    }

    /**User related functions**/
    function transferToUserViaMsgValue(address _to) external payable {
        require(address(this).balance >= msg.value, "Insufficient Balance");
        transactionHistory.push(
            Transaction({
                from: msg.sender,
                to: _to,
                timeStamp: block.timestamp,
                amount: msg.value
            })
        );
        emit Transfer(_to, msg.value);
    }

    function receiveFromUser() external payable {
        require(msg.value > 0, "Wei Value must be greater than zero");
        transactionHistory.push(
            Transaction({
                from: msg.sender,
                to: owner,
                timeStamp: block.timestamp,
                amount: msg.value
            })
        );
        emit Receive(msg.sender, msg.value);
        emit ReceiveUser(msg.sender, owner, msg.value);
    }

    function getOwnerBalanceInWei() external view returns (uint256) {
        return owner.balance;
    }

    receive() external payable {
        transactionHistory.push(
            Transaction({
                from: msg.sender,
                to: address(this),
                timeStamp: block.timestamp,
                amount: msg.value
            })
        );
        emit Receive(msg.sender, msg.value);
    }

    fallback() external {}
}

//Add the following features
//1.List of receivers with amount
//2.List of transfers with amount
