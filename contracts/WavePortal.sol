// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;

    event NewWave(address indexed from, uint256 timestamp, string message);

    struct Wave {
        address waver;
        uint256 timestamp;
        string message;
    }

    Wave[] waves;

    constructor() {
        console.log("Here we go, Adol Smart Contract!!!");
    }

    function wave(string memory _message) public {
        totalWaves++;
        console.log("%s has waved!", msg.sender);
        
        waves.push(Wave(msg.sender, block.timestamp, _message));

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
