// SPDX-License-Identifier: GPL-3
pragma solidity ^0.8.0;

import './RWD.sol';
import './Tether.sol';

/**
 * @title Decentralized Bank
 * @notice A Decentralized bank where you can deposit your money and take reward
 * @dev It interacts with Tether and RWD tokens as well
 * @author Arian
 */
contract DecentralBank {
	string public name = "Decentral Bank";
	address public owner;

	Tether public tether;
	RWD public rwd;
	
	mapping(address => uint) public stakingBalance;

	constructor(RWD _rwd, Tether _tether) {
		rwd = _rwd;
		tether = _tether;
	}

	/// @notice A staking function which allows you to deposit your money (tokens) and take reward
	function deposit(uint _amount) public {
		// Transfer tether tokens to this contract address for staking
		tether.transferFrom(msg.sender, address(this), _amount);

		stakingBalance[msg.sender] += _amount;
	}
}