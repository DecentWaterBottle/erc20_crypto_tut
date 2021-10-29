pragma solidity ^0.8.9;
import "./MediCoin.sol";

contract MediCoinSale {
    address admin;
    uint256 public coinPrice;
    MediCoin public tokenContract;
    uint256 public tokensSold;

    event Sell(address _buyer, uint256 _amount);

    constructor(MediCoin _tokenContract, uint256 _coinPrice) {
        admin = msg.sender;
        coinPrice = _coinPrice;
        tokenContract = _tokenContract;
    }

    // Safe Multiplication from DS-Math
    function multiply(uint x, uint y) internal pure returns (uint z) {
        require(y == 0 || (z = x * y) / y == x);
    }
    // Token Buying
    function buyTokens(uint256 _numberOfTokens) public payable {
        require(msg.value == multiply(_numberOfTokens, coinPrice));
        require(tokenContract.balanceOf(address(this)) >= _numberOfTokens);
        require(tokenContract.transfer(msg.sender, _numberOfTokens));
        tokensSold += _numberOfTokens;
        emit Sell(msg.sender, _numberOfTokens);
    }

    function endSale() public {
        require(msg.sender == admin);
        require(tokenContract.transfer(admin, tokenContract.balanceOf(address(this))));
        // address payable admin_addr = payable(address(admin));
        selfdestruct(payable(admin));
    }
}