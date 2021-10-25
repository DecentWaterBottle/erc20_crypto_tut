var MediCoin = artifacts.require("./MediCoin.sol");

contract("MediCoin", function(accounts){
    var tokenInstance;

    it('initializes the contract with the correct values', function(){
        return MediCoin.deployed().then(function(instance){
            tokenInstance = instance;
            return tokenInstance.name();
        }).then(function(name){
            assert.equal(name, 'MediCoin', 'has the correct name');
            return tokenInstance.symbol();
        }).then(function(symbol){
            assert.equal(symbol,"MEDI", "has the correct symbol");
            return tokenInstance.standard();
        }).then(function(standard){
            assert.equal(standard, "Medi Coin v1.0", "has the correct standard");
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
            assert.equal(adminBalance.toNumber(), 1000000000, "it allocates the initial supply to the admin account");
        });
    });

    it("transfers token ownership", function(){
        return MediCoin.deployed().then(function(instance){
            tokenInstance = instance;
            // Test by sending a larger amount than the sender's balance
            return tokenInstance.transfer.call(accounts[1], 9999999999999);
        }).then(assert.fail).catch(function(error){
            assert(error.message.indexOf("revert") >= 0, "error message must contain revert");
            return tokenInstance.transfer(accounts[1], 500000000, { from: accounts[0]});
        }).then (function(receipt){
            return tokenInstance.balanceOf(accounts[1]);
        }).then(function(balance){
            assert.equal(balance.toNumber(), 500000000, "adds the amount to the receiving account");
            return tokenInstance.balanceOf(accounts[0]);
        }).then(function(balance) {
            assert.equal(balance.toNumber(), 500000000, "deducts the amount from the sending account");
        });
    });
});

//134:14