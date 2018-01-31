var controller = artifacts.require("Controller");
var tokenSellerFactory = artifacts.require("TokenSellerFactory");
var token = artifacts.require("H2ICO");
var tokenSeller = artifacts.require("TokenSeller");
module.exports = function(deployer) {
  
  
  let address
  deployer.deploy(token);
  

  token.deployed().then(async (result) => {
     address = result.address
     
  }).then(function(){

    deployer.deploy(tokenSellerFactory,address);
    
  }).then(function(){  

      deployer.deploy(controller);
      controller.deployed().then(async function(instance) {
      instance.setTokenAddr(address);
      
       
  })  
  });

  
    
  
  
  
};