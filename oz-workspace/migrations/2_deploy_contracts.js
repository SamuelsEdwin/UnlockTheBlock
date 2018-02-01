var controller = artifacts.require("Controller");
var tokenSeller = artifacts.require("TokenSellerFactory");
var token = artifacts.require("H2ICO");
<<<<<<< HEAD
var tokenSeller = artifacts.require("TokenSeller");
/*
module.exports = function(deployer) {
  deployer.deploy(token)
    .then(() => {
      return token.deployed()
        .then(t => {
          tok = t;
          deployer.deploy(tokenSellerFactory,tok.address);
          deployer.deploy(controller,tok.address);
          return controller.deployed().then(c => {
            control = c;
            console.log('Controller:', control.address)
            tok.transferOwnership(control.address).then((res) => {
            console.log('Changed controller!', res.tx);
            });
          })
        })
      })
};
*/

module.exports = function(deployer) {
  deployer.deploy(controller, "0x0").then(() => {
    return controller.deployed().then(t => {
      control = t;
      return token.new()})
      .then(t => {
        tok = t;
        tok.transferOwnership(control.address);
      })
  })
}
=======
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
>>>>>>> 25c47ce9274a2ff71cf7d85a80bac4ade2630fd7
