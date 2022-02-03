// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Cryptwit {
    event NewTweet(address indexed from, uint256 timestamp, string message);

    struct Tweet {
        address tweeter;
        string message;
        uint256 timestamp;
    }

    Tweet[] tweets;


    function tweet(string memory _message) public {
        tweets.push(Tweet(msg.sender, _message, block.timestamp));
        emit NewTweet(msg.sender, block.timestamp, _message);
    }

    function tip(address payable _to) public payable {
        _to.transfer(msg.value);
    }

    function getTweets() public view returns (Tweet[] memory) {
        return tweets;
    }
}