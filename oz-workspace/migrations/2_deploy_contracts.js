var controller = artifacts.require("Controller");

module.exports = function(deployer) {
  deployer.deploy(controller)
  let controlInstance; 
  controller.deployed().then(async function(instance) {
    controlInstance = instance;
    controlInstance.generateToken();    
  })
};