const MediCoin = artifacts.require("./MediCoin.sol");

module.exports = function (deployer) {
  deployer.deploy(MediCoin, 1000000000);
};
