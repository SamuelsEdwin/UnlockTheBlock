var controller = artifacts.require("Controller");
var H2ICO = artifacts.require("H2ICO");

contract('controller',function(accounts) {

    let control;
    let token;
    let tokenAddress;
    let controllerAddress;
    let tokenOwnerAddress;

    beforeEach(async () => {
<<<<<<< HEAD
        token = await H2ICO.new({from: accounts[0]});
        control = await controller.new(token.address, {from: accounts[0]});
=======
        token = await H2ICO.new();
        tokenAddress = await token.address;
        control = await controller.new(tokenAddress);
        controllerAddress = await controller.address;
        
        await token.transferOwnership(controllerAddress,{from: accounts[0]});
        tokenOwnerAddress = await token.owner();
>>>>>>> e9acc0a9651eac408fdc61aacb1acafc525b1ab8
        //token = control.generateToken();
      
    });
    it("Controller is token owner", async function() {

        assert.equal(tokenOwnerAddress,controllerAddress,"controller is not owner");
        assert.notEqual(tokenOwnerAddress,accounts[0],"controller is not owner");


    });

    it("controller should be owner", async function() {
        await token.transferOwnership(control.address, {from: accounts[0]})
        const user = await token.owner();
        assert.equal(user,control.address,"Controller not owner")
    });

    it("should add user", async function() {
        await control.addUser(accounts[1]);
        const user = await control.containsUser(accounts[1]);
        assert.equal(user,true,"User not added")
    });

    it("should fail to add user twice", async function() {
        await control.addUser(accounts[1]);
        const user = await control.getTotalUsers();
        assert.equal(user,1,"User not added");
        await control.addUser(accounts[1]);
        const user2 = await control.getTotalUsers();
        assert.equal(user2,1,"User added Twice")
    });

    it("should remove user", async function() {
        await control.addUser(accounts[1]);
        const user = await control.containsUser(accounts[1]);
        assert.equal(user,true,"User not added")
        await control.removeUser(accounts[1]);
        const noUser = await control.containsUser(accounts[1]);
        assert.equal(noUser,false,"User not removed")
    });

    it("should fail to remove non-user", async function() {
        await control.addUser(accounts[1]);
        const user0 = await control.getTotalUsers();
        assert.equal(user0,1,"User not added");
        await control.removeUser(accounts[1]);
        const user1 = await control.getTotalUsers();
        assert.equal(user1,0,"User not removed");
        await control.removeUser(accounts[1]);
        const user2 = await control.getTotalUsers();
        assert.equal(user2,0,"User removed twice")
    });

    // it ("should have a water limit of 80",function(){
    //     return controller.deployed().then(function(instance){
    //          instance.generateToken();
    //          instance.setUserWaterLimit(80);
    //          return instance.getUserWaterLimit();
    //     }).then(function(waterLimit) {
    //         assert.equal(waterLimit.valueOf(),80,"80 wasn't the water limit")

    //     });
    // });

    it ("should have a water limit of 80", async () => {
        let set
        let get
        set = await control.setUserWaterLimit(80, {from: accounts[0]});
        get = await control.getUserWaterLimit.call();
        assert.equal(80,get.toNumber(),"80 wasn't the water limit")
    });

    it ("should not change from 80 to 90", async () => {
        let get
        await control.setUserWaterLimit(80, {from: accounts[0]});
        await control.setUserWaterLimit(90, {from: accounts[1]});
        get = await control.getUserWaterLimit.call();
        assert.equal(80,get.toNumber(),"80 wasn't the water limit")
    });
/*
    it ("should exchange tokens", async () => {
        let get

        //test if exchange works under normal conditions
        await control.setUserWaterLimit(100, {from: accounts[0]});
        await control.addUser(accounts[1]);
        await control.addUser(accounts[2]);
        await control.withdraw({from:accounts[1]});
        const balance = await control.getBalance(accounts[1]);
        assert.equal(100, balance.toNumber(), "Withdrawal unsuccessful");


        control.requestSale(100,{from: accounts[1]});
        await control.exchange(accounts[1], accounts[2], 100);
        const balanceOne = await control.getBalance(accounts[2]);
        assert.equal(95,balanceOne.toNumber(),"Incorrectly exchanged");
        const balanceTwo = await control.getBalance(accounts[1]);
        assert.equal(0, balanceTwo.toNumber(),"Balance not reduced")

        // Test for?
        //test to get lost water
        // await control.exchange(accounts[1], accounts[2], 5);
        // const balanceThree = await control.getBalance(accounts[2]);
        // assert.equal(95,balanceThree.toNumber(),"incorrectly got burnt water ");

    });
*/
    it ("should return the correct number of users", async () => {
        await control.addUser(accounts[1]);
        await control.addUser(accounts[2]);
        const addUserCount = await control.getTotalUsers();
        assert.equal(2,addUserCount.toNumber(),"Incorrect Number of users recorded");
        await control.removeUser(accounts[2]);
        const rmUserCount = await control.getTotalUsers();
        assert.equal(1,rmUserCount.toNumber(),"Incorrect Number of users after remove")
    });

    it("should withdraw Tokens", async function() {
        await token.transferOwnership(control.address, {from: accounts[0]})
        const user = await token.owner();
        assert.equal(user,control.address,"Controller not owner")
        await control.addUser(accounts[1]);
        const addUserCount = await control.getTotalUsers();
        assert.equal(1,addUserCount.toNumber(),"Incorrect Number of users recorded");
        await control.setUserWaterLimit(80);
        const waterLimit = await control.getUserWaterLimit();
        assert.equal(80,waterLimit.toNumber(),"Incorrect Water Limit Set");
        await control.withdraw({from: accounts[1]});
        const balance0 = await control.getBalance(accounts[1]);
        assert.equal(balance0.toNumber(), 80, "Balance was not withdrawn");
        await control.withdraw({from: accounts[1]});
        const balance1 = await control.getBalance(accounts[1]);
        assert.equal(balance1.toNumber(), 80, "Balance was withdrawn twice")
       
    });

});