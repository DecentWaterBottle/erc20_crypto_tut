
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


abstract contract MediCoinInterface {
    function totalSupply()public view virtual returns (uint256);
    function transfer(address _to, uint256 _value) public virtual returns(bool success);
    function allowance(address _owner, address _spender) public view virtual returns (uint256);
    function transferFrom(address _from, address _to,  uint256 _value) public virtual returns (bool success);
    function balanceOf(address account) public view virtual returns (uint256);
    function approve(address _spender, uint256 _value) public virtual returns(bool success);
}

contract MediCoin is MediCoinInterface{

    // Name
    string public name = "MediCoin";
    // Symbol
    string public symbol = "MEDI";
    // Standard
    string public standard = "Medi Coin v1.0";
    // Decimals 
    uint8 public decimals;

    uint256 public _totalSupply;
    // Transfer Event
    event Transfer(address indexed _from, address indexed _to,uint256 _value);

    // Approval Event
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);

    // mapping(address => uint256) public balanceOf;
    mapping(address  => uint) balances;
    mapping(address => mapping(address => uint256)) public allowed;


    constructor () {
        
        // Giving initial supply to first account
        decimals = 18;
        
        // totalSupply = _initialSupply;
        _totalSupply = 1000000000 * 10**uint(decimals);
        balances[msg.sender] = _totalSupply;
    }

    // Transfer Tokens
    function transfer(address _to, uint256 _value) public override returns(bool success){
        require(balances[msg.sender] >= _value);
        // Changing Balances
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        // Calling transfer event
        emit Transfer(msg.sender, _to, _value);

        return true;
    }

    // Total Supply
    function totalSupply() public view override returns (uint256) {
        return _totalSupply;
    }

    function allowance(address _owner, address _spender) public view override returns (uint256) {
        return allowed[_owner][_spender];
    }

    // Transfer From
    function transferFrom(address _from, address _to,  uint256 _value) public override returns (bool success){
        require(_value <= balances[_from]);
        require(_value <= allowed[_from][msg.sender]);
        balances[_from] -= _value;
        balances[_to] += _value;
        allowed[_from][msg.sender] -= _value;
        emit Transfer(_from, _to, _value);

        return true;
    }

    function balanceOf(address account) public view override returns (uint256) {
        return balances[account];
    }

    // Approve Function
    function approve(address _spender, uint256 _value) public override returns(bool success) {
        
        allowed[msg.sender][_spender] = _value;
        
        emit Approval(msg.sender, _spender, _value);
        return true;
    }
}
