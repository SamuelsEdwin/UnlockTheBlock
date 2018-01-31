var controller = artifacts.require("Controller");
var tokenSellerFactory = artifacts.require("TokenSellerFactory");
var token = artifacts.require("H2ICO");
var tokenSeller = artifacts.require("TokenSeller");
module.exports = function(deployer) {
  
  
  let address;
  
  

  deployer.deploy(token).then(function() {
    deployer.deploy(tokenSellerFactory,token.address).then(() => {
      deployer.deploy(controller,token.address).then( function() {
        
        token.deployed().then( function(instance){
          instance.transferOwnership(controller.address);
         
        })
        
    });
     
  })
  });

  
    
  
  
  
};