let FlowerShop = artifacts.require("FlowerShop");
module.exports = function(_deployer) {
  // Use deployer to state migration tasks.
  _deployer.deploy(FlowerShop);
};
