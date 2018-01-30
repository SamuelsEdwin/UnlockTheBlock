var controller = artifacts.require("Controller");

contract('controller',function(accounts) {
<<<<<<< HEAD

    let control;
    let token;

    beforeEach(async () => {
        control = await controller.new();
        token = control.generateToken();
    });

    it("should add user", async function() {
        await control.addUser(accounts[1]);
        const user = await control.containsUser(accounts[1]);
        assert.equal(user,true,"User not added")
    });

    it("should withdraw Tokens", async function() {
        await control.addUser(accounts[1]);
        await control.setUserWaterLimit(80);
        await control.withdraw({from: accounts[1]});
        const balance0 = await control.getBalance(accounts[1]);
        assert.equal(balance0.toNumber(), 80, "Balance was updated")
    });


    it ("should have a water limit of 80",function(){
        return controller.deployed().then(function(instance){
             instance.generateToken();
             instance.setUserWaterLimit(80);
             return instance.getUserWaterLimit();
        }).then(function(waterLimit) {
            assert.equal(waterLimit.valueOf(),80,"80 wasn't the water limit")

        });
    });

    // it ("should add user", function(){
    //     return controller.deployed().then(function(instance){
    //         instance.generateToken();
    //         instance.addUser(accounts[0]);
    //     return instance.containsUser(accounts[0]);
    //     }).then(function(user) {
    //         assert.equal(user,true,"User not added")
    //     });
    // });
=======
   let control
    beforeEach(async () => {
        control = await controller.new()
    })
    
    it ("should have a water limit of 80", async () => {
        let set
        let get
        await control.generateToken();
        set = await control.setUserWaterLimit(80, {from: accounts[0]});
        get = await control.getUserWaterLimit.call();
        assert.equal(80,get.toNumber(),"80 wasn't the water limit")
    });

    // it ("should add user", function(){
    //     return control.deployed().then(function(instance){
    //     instance.generateToken();
    //     instance.addUser(accounts[0]);
        
    //     return instance.containsUser(accounts[0]);
    //     }).then(function(user) {
    //         assert.equal(user,true,"User not added");
           

    //     });
    // });

>>>>>>> 290f6dddffe3b6b7b43d6c82ae31a06d7c713216

});