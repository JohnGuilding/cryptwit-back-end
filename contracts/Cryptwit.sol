// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Cryptwit {
    uint totalTweets;
    uint256 private seed;

    event newTweet(address indexed from, uint256 timestamp, string message);

    struct Tweet {
        address tweeter;
        string message;
        uint256 timestamp;
    }

    Tweet[] tweets;

    constructor() payable {

    } 

    function tweet(string memory _message) public {
        // Add tweet to tweets array
        // emit new tweet event
    }

    function getTweets() public view returns (Tweet[] memory) {
        return tweets;
    }

    function getTotalTweets() public view returns (uint256) {
        return totalTweets;
    }
}