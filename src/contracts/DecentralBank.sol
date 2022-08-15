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

	modifier onlyOwner {
		require(msg.sender == owner, "You're not the owner!");
		_;
	}

	// Keep track of investor's deposit
	mapping(address => uint) public stakingBalance;
	mapping(address => bool) public hasStaked;
	mapping(address => bool) public isStaking;

	constructor(RWD _rwd, Tether _tether) {
		rwd = _rwd;
		tether = _tether;
		owner = msg.sender;
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

	/// @notice Issue rewards to clients
	// Only owner can call this function
	function issueTokens() public onlyOwner {
		// require(msg.sender == owner, "You're not the owner!");
		for (uint i = 0; i < stakers.length; i++) {
			address recipient = stakers[i];
			uint balance = stakingBalance[recipient]; // the balance of recipient

			if (balance > 0) {
				rwd.transfer(payable(recipient), balance/9); // if they stake 27 USDT tokens, they're gonna get 9 RWD (one ninth of that)
			}
		}
	}

	/// @notice Customers can unstake or take their tokens back
	function unstakeTokens() public {
		// the balance of our customer (the person who's calling the function)
		uint balance = stakingBalance[msg.sender];
		// Require the amount to be greater than 0
		require(balance > 0, "Staking Balance cannot be less or equal to 0");

		// Transfer tokens to the specified contract address from our bank
		// Transfer customer's staked tokens to their account
		tether.transfer(payable(msg.sender), balance);

		// Updateing stakingBalance in our DApp (Our DApp should understand they took their tokens back)
		stakingBalance[msg.sender] -= balance;

		// Update our staking status
		isStaking[msg.sender] = false;
	}

}