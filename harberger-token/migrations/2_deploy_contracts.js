var HarbergerToken = artifacts.require("./HarbergerToken.sol");

module.exports = function(deployer) {
  deployer.deploy(HarbergerToken);
};
