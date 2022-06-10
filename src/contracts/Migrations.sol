// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Migrations {
    address public owner;
    uint256 public last_completed_migration;

    constructor() {
        owner = msg.sender;
    }

    // onlyOwner modifier
    modifier restricted() {
        if (msg.sender == owner) _;
        // require(owner == msg.sender);
        // _;
    }

    // only owner can call this function (the person who is calling the contract)
    function setCompleted(uint256 completed) public restricted {
        last_completed_migration = completed;
    }

    function upgrade(address new_address) public restricted {
        Migrations upgraded = Migrations(new_address);
        upgraded.setCompleted(last_completed_migration);
    }
}
