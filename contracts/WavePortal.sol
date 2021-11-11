// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;
    uint256 private seed;
    struct Wave {
        address waver;
        uint256 timestamp;
        string message;
    }
    Wave[] waves;
    mapping(address => uint256) public lastWavedAt;

    event NewWave(address indexed from, uint256 timestamp, string message);


    constructor() payable {
        console.log("Here we go, Adol Smart Contract!!!");

        //Initial seed
        seed = (block.timestamp + block.difficulty) % 100;
    }

    function wave(string memory _message) public {
        require(
            lastWavedAt[msg.sender] + 15 minutes < block.timestamp,
            "Wait 15m"
        );
        lastWavedAt[msg.sender] = block.timestamp;

        totalWaves++;
        console.log("%s has waved!", msg.sender);

        waves.push(Wave(msg.sender, block.timestamp, _message));

        seed = (block.difficulty + block.timestamp) % 100;

        /*
         * Give a 50% chance that the user wins the prize.
         */
        if (seed <= 50) {
            console.log("%s won!", msg.sender);

            uint256 prizeAmount = 0.0001 ether;
            require(
                prizeAmount <= address(this).balance,
                "Trying to withdraw more money than the contract has."
            );
            (bool success, ) = (msg.sender).call{value: prizeAmount}("");
            require(success, "Failed to send prize to sender.");
        }

        emit NewWave(msg.sender, block.timestamp, _message);
    }

    function getTotalWaves() public view returns (uint256) {
        console.log("We have %d total waves!", totalWaves);
        return totalWaves;
    }

    function getAllWaves() public view returns (Wave[] memory) {
        console.log("Here are the wavers!");
        return waves;
    }
}
