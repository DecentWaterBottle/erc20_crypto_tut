pragma solidity ^0.8.9;

contract MediCoin{

    // Name
    string public name = "MediCoin";
    // Symbol
    string public symbol = "MEDI";

    uint256 public totalSupply;

    mapping(address => uint256) public balanceOf;

    constructor (uint256 _initialSupply) {
        balanceOf[msg.sender] = _initialSupply;
        totalSupply = _initialSupply;
        
    }
}
