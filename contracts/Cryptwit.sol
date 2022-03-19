// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract Cryptwit {
    uint totalTweets;
    uint256 private seed;

    event NewTweet(address indexed from, uint256 timestamp, string message);
    event Deposit(uint amount);

    struct Tweet {
        address tweeter;
        string message;
        uint256 timestamp;
    }

    Tweet[] tweets;

    mapping(address => uint256) public lastTweetedAt;

    constructor() payable {
        console.log('%d deposited into the lottery', msg.value);
        seed = (block.timestamp + block.difficulty) % 100;
    }

    function tweet(string memory _message) public {
        require(lastTweetedAt[msg.sender] + 30 seconds < block.timestamp,
        'You must wait at least 30 seconds before tweetng again');

        lastTweetedAt[msg.sender] = block.timestamp;
        totalTweets += 1;
        console.log("%s has tweeted", msg.sender);

        tweets.push(Tweet(msg.sender, _message, block.timestamp));

        drawFromLottery();
        emit NewTweet(msg.sender, block.timestamp, _message);
    }

    function tip(address payable _to) public payable {
        _to.transfer(msg.value);
    }

    function getTweets() public view returns (Tweet[] memory) {
        return tweets;
    }

    function drawFromLottery() internal {
        seed = (block.timestamp + block.difficulty + seed) % 100; 
        console.log("Random # generated: %d", seed);

        if (seed <= 50) {
            console.log("%s won!", msg.sender);
            (bool success, ) = (msg.sender).call{value: address(this).balance}('');
            require(success, 'Failed to withdraw money from contract');
        }
    }

    receive() external payable {
        emit Deposit(msg.value);
    }
}