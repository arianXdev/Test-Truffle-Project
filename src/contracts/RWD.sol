// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title Reward Token
 * @author Arian Hosseini
 */
contract RWD {
    string public name = "Reward Token";
    string public symbol = "RWD";
    uint256 public totalSupply = 1000000000000000000000000; // 1 million tokens
    uint8 public decimals = 18;

    // indexed: when we add indexed, this essentially allows us to filter through the address so that we can search for them
    /// @notice uses whenever we have a transfer call
    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    /// @notice uses whenever we have a successful transfer call
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);

    /// We're going to use some mapping in order to keep track of balance
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    constructor() {
        balanceOf[msg.sender] = totalSupply;
    }

    /// @notice uses to transfer an amount to a receiver (ethereum account)
    /// @dev returns a boolean if the transcation is succeed
    function transfer(address payable _to, uint256 _value) public payable returns (bool success) {
        /// @notice Requires that the value has to be greater than or equal to the balance for transfer
        require(balanceOf[msg.sender] >= _value, "Your balance is not enough!");

        // transfers the amount and subtracts the balance
        balanceOf[msg.sender] -= _value;
        // adds the balance
        balanceOf[_to] += _value; // _to.transfer(_value)

        /// Making the event happen
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function approve(address _spender, uint256 _value) public returns (bool success) {
        allowance[msg.sender][_spender] = _value;

        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    // Coding is all about making mistakes
    function transferFrom(address _from,address _to,uint256 _value) public returns (bool success) {
        require(_value <= balanceOf[_from]);
        require(_value <= allowance[_from][msg.sender]);


        // adds the balance
        balanceOf[_to] += _value; // _to.transfer(_value)
        // subtract the balance
        balanceOf[_from] -= _value;

        allowance[_from][msg.sender] -= _value;

        emit Transfer(_from, _to, _value);
        return true;
    }
}
