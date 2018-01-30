var controller = artifacts.require("Controller");

contract('controller',function(accounts) {
    it ("should have a water limit of 80",function(){
        return controller.deployed().then(function(instance){
             instance.generateToken();
             instance.setUserWaterLimit(80);
             return instance.getUserWaterLimit();
        }).then(function(waterLimit) {
            assert.equal(waterLimit.valueOf(),80,"80 wasn't the water limit")

        });
    });

    it ("should add user", function(){
        return controller.deployed().then(function(instance){
        instance.generateToken();
        instance.addUser(accounts[0]);
        return instance.containsUser(accounts[0]);
        }).then(function(user) {
            assert.equal(user,true,"User not added")
        });
    });


});