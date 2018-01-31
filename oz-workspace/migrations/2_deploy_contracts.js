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
          return tokenSellerFactory.new(t.address)
        })
        .then(() => {
          console.log('FRN:', token.address)
          return controller.new(token.address)
        })
        .then(c => {
          controller = c;
          console.log('Controller:', c.address)
          token.transferOwnership(c.address).then((res) => {
            console.log('Changed controller!', res.tx);
          });
        })
    })
};