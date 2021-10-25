pragma solidity ^0.8.9;

contract MediCoin{

    // Name
    string public name = "MediCoin";
    // Symbol
    string public symbol = "MEDI";
    // Standard
    string public standard = "Medi Coin v1.0";


    uint256 public totalSupply;

    mapping(address => uint256) public balanceOf;

    constructor (uint256 _initialSupply) {
        balanceOf[msg.sender] = _initialSupply;
        totalSupply = _initialSupply;
        
    }

    //Transfer
    function transfer(address _to, uint256 _value) public returns(bool success){
        require(balanceOf[msg.sender] >= _value);

        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
    }
}
