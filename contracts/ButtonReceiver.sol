// SPDX-License-Identifier: MIT

pragma solidity ^0.8.11;

contract ButtonReceiver { 
    address payable owner; // contract creator's address
    mapping (address => bool) internal whitelist; // whitelisted users (users who have paid)

    //contract settings
    constructor() {
        owner = payable(msg.sender); // setting the contract creator
    }

    // receive money
    receive() payable external {
        require(!isWhiteListed(msg.sender), "User has already Paid!");
        (bool success,) = owner.call {value: msg.value}("");
        require(success, "Failed to send money");
        whitelist[msg.sender] = true;
    }

    function isWhiteListed(address _addr) public view returns (bool) {
        return whitelist[_addr];
    }

} 