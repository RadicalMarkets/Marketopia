var HarbergerToken = artifacts.require("./HarbergerToken.sol");

module.exports = function(deployer) {
  deployer.deploy(HarbergerToken, 100, "HarbergerToken", "HT", 2, 1);
};

// contract addresss - 0x3ef6854bca9e9c450ca26cf182b873160b8e57b9
// Ganache address 1 is Tax Collector 

