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
	
	address[] public stakers;

	// Keep track of investor's deposit
	mapping(address => uint) public stakingBalance;
	mapping(address => bool) public hasStaked;
	mapping(address => bool) public isStaking;

	constructor(RWD _rwd, Tether _tether) {
		rwd = _rwd;
		tether = _tether;
	}

	/// @notice It's going to transfer investor's tether tokens to this contract for staking (deposit USDT tokens in our DApp)
	function depositTokens(uint _amount) public {
		// require staking amount to be greater than zero
		require(_amount > 0, "The amount cannot be less than or equal to 0!");

		tether.transferFrom(msg.sender, address(this), _amount);

		// Keep track of how much the investor wants to deposit
		stakingBalance[msg.sender] += _amount;

		if(!hasStaked[msg.sender]) {
			stakers.push(msg.sender);
		}

		isStaking[msg.sender] = true;
		hasStaked[msg.sender] = true;
	}
}