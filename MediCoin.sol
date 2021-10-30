
pragma solidity ^0.8.9;

//====================================================
// 
// Name: Medi Coin
// Symbol: MEDI
// Total Supply: 1,000,000,000 (1 billion)
//
//
//
//
//====================================================

contract MediCoin{

    // Name
    string public name = "MediCoin";
    // Symbol
    string public symbol = "MEDI";
    // Standard
    string public standard = "Medi Coin v1.0";
    // Decimals 
    uint8 public decimals;

    uint256 public totalSupply;
    // Transfer Event
    event Transfer(address indexed _from, address indexed _to,uint256 _value);

    // Approval Event
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);

    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;


    constructor () {
        
        // Giving initial supply to first account
        decimals = 18;
        
        // totalSupply = _initialSupply;
        totalSupply = 1000000000 * 10**uint(decimals);
        balanceOf[msg.sender] = totalSupply;
    }

    // Transfer Tokens
    function transfer(address _to, uint256 _value) public returns(bool success){
        require(balanceOf[msg.sender] >= _value);

        // Changing Balances
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        // Calling transfer event
        emit Transfer(msg.sender, _to, _value);

        return true;
    }

    // Transfer From
    function transferFrom(address _from, address _to,  uint256 _value) public returns (bool success){
        require(_value <= balanceOf[_from]);
        require(_value <= allowance[_from][msg.sender]);
        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
        allowance[_from][msg.sender] -= _value;
        emit Transfer(_from, _to, _value);

        return true;
    }

    // Approve Function
    function approve(address _spender, uint256 _value) public returns(bool success) {
        
        allowance[msg.sender][_spender] = _value;
        
        emit Approval(msg.sender, _spender, _value);
        return true;
    }
}
