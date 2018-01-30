var controller = artifacts.require("Controller");

contract('controller',function(accounts) {
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


});