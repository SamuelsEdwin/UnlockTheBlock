var controller = artifacts.require("Controller");
var tokenSellerFactory = artifacts.require("TokenSellerFactory");
var token = artifacts.require("H2ICO");
var tokenSeller = artifacts.require("TokenSeller");

module.exports = function(deployer) {
  deployer.deploy(token)
    .then(() => {
      return token.deployed()
        .then(t => {
          token = t;
          deployer.deploy(tokenSellerFactory,token.address);
          deployer.deploy(controller,token.address);
          return controller.deployed().then(c => {
            controller = c;
            console.log('Controller:', controller.address)
            token.transferOwnership(controller.address).then((res) => {
            console.log('Changed controller!', res.tx);
            });
          })
        })
      })
};