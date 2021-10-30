const MediCoin = artifacts.require("./MediCoin.sol");
var MediCoinSale = artifacts.require("./MediCoinSale.sol");

module.exports = function (deployer) {
  deployer.deploy(MediCoin).then(function(){
    return deployer.deploy(MediCoinSale, MediCoin.address, 1000000000000000);
  });
};
