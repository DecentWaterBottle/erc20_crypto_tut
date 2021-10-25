pragma solidity ^0.8.9;

contract MediCoin{

    // Name
    string public name = "MediCoin";
    // Symbol
    string public symbol = "MEDI";
    // Standard
    string public standard = "Medi Coin v1.0";


    uint256 public totalSupply;
    // Transfer Event
    event Transfer(address indexed _from, address indexed _to,uint256 _value);

    mapping(address => uint256) public balanceOf;

    constructor (uint256 _initialSupply) {
        // Giving initial supply to first account
        balanceOf[msg.sender] = _initialSupply;
        totalSupply = _initialSupply;
        
    }

    //Transfer Function
    function transfer(address _to, uint256 _value) public returns(bool success){
        require(balanceOf[msg.sender] >= _value);

        // Changing Balances
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        // Calling transfer event
        emit Transfer(msg.sender, _to, _value);

        return true;
    }
}
