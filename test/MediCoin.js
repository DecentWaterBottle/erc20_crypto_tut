var MediCoin = artifacts.require("./MediCoin.sol");

contract("MediCoin", function(accounts){
    var tokenInstance;

    it('initializes the contract with the correct values', function(){
        return MediCoin.deployed().then(function(instance){
            tokenInstance = instance;
            return tokenInstance.name();
        }).then(function(name){
            assert.equal(name, 'MediCoin', 'has the correct name');
        }).then(function(symbol){
            assert.equal(symbol,"MEDI", "has the correct symbol");
        });
    })

    it('allocates the initial supply upon deployment', function(){
        return MediCoin.deployed().then(function(instance){
            tokenInstance = instance;
            return tokenInstance.totalSupply();
        }).then(function(totalSupply){
            assert.equal(totalSupply.toNumber(), 1000000000, "sets the total supply to 1,000,000,000");
            return tokenInstance.balanceOf(accounts[0]);
        }).then(function(adminBalance){
            assert.equal(adminBalance.toNumber(), 1000000000, "it allocates the initial supply to the admin account")
        });
    });
});