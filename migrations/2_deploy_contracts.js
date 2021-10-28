const MediCoin = artifacts.require("./MediCoin.sol");
var MediCoinSale = artifacts.require("./MediCoinSale.sol");

module.exports = function (deployer) {
  deployer.deploy(MediCoin, 1000000000);
  deployer.deploy(MediCoinSale);
};
