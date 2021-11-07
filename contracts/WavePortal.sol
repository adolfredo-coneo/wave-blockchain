// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;
    address[] wavers;

    constructor() {
        console.log("Here we go, Adol Smart Contract!!!");
    }

    function wave() public {
        totalWaves++;
        wavers.push(msg.sender);
        console.log("%s has waved!", msg.sender);
    }

    function getTotalWaves() public view returns (uint256) {
        console.log("We have %d total waves!", totalWaves);
        return totalWaves;
    }

    function getWavers() public view returns (address[] memory) {
        console.log("Here are the wavers!");
        return wavers;
    }
}
