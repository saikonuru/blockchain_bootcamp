// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract demo {
    function get() external pure returns (string memory) {
        return "Jai Ganesha!";
    }

    struct Tweet {
        uint256 id;
        address author;
        string content;
        uint256 createdAt;
    }

    struct Message {
        uint256 id;
        string content;
        address from;
        address to;
        uint256 createdAt;
    }

    mapping(uint256 => Tweet) public tweets;
    mapping(uint256 => uint256[]) public tweetsOf;
    mapping(address => Message[]) public conversations;
    mapping(address => mapping(address => bool)) public operators;
    mapping(address => address[]) public followers;

    uint256 public nextId;
    uint256 public nextMessageId;

    function _tweet(address _from, string memory _content) public {
        tweets[nextId] = Tweet(nextId, _from, _content, block.timestamp);
        nextId++;
    }

    function _sendMessage(
        address _from,
        address _to,
        string memory _content
    ) public {
        conversations[_from].push(
            Message(nextMessageId, _content, _from, _to, block.timestamp)
        );
        nextMessageId++;
    }

    function _tweet(string memory _content) public {
        _tweet(msg.sender, _content);
    }

    function tweet(address _from, string memory _content) public {
        _tweet(_from, _content);
    }

    function sendMessage(
        address _from,
        address _to,
        string memory _content
    ) public {
        _sendMessage(_from, _to, _content);
    }

    function sendMessage(string memory _content, address _to) public {
        _sendMessage(msg.sender, _to, _content);
    }

    function follow(address _followed) public {
        followers[msg.sender].push(_followed);
    }

    function allow(address _operator) public {
        operators[msg.sender][_operator] = false;
    }

    function getLatestTweets(uint count) public  {

    }
}
