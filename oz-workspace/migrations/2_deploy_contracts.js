var controller = artifacts.require("Controller");
var tokenSeller = artifacts.require("TokenSellerFactory");
var token = artifacts.require("H2ICO");
module.exports = function(deployer) {
  
  
  let address
  deployer.deploy(token);
  deployer.deploy(controller);

  token.deployed().then(async (result) => {
     address = result.address
     
  }).then(function(){

    deployer.deploy(tokenSeller,address);
    
  }).then(function(){  

      controller.deployed().then(async function(instance) {
      instance.setTokenAddr(address);
      
       
  })  
  });

  
    
  
  
  
};