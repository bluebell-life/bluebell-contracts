let BlueBellToken = artifacts.require("BlueBellToken");
module.exports = function(_deployer) {
  // Use deployer to state migration tasks.
  _deployer.deploy(BlueBellToken, 10*1000*1000*1000);
};
