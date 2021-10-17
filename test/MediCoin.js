var MediCoin = artifacts.require("./MediCoin.sol");

contract("MediCoin", function(accounts){
    it('sets the total supply upon deployment', function(){
        return MediCoin.deployed().then(function(instance){
            tokenInstance = instance;
            return tokenInstance.totalSupply();
        }).then(function(totalSupply){
            assert.equal(totalSupply.toNumber(), 1000000000, "sets the total supply to 1,000,000,000");
        });
    });
})