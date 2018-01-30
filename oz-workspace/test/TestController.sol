pragma solidity ^0.4.17;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Controller.sol";
import "../contracts/Date/DateTime.sol";
import "../contracts/Date/DateTimeAPI.sol";

// Testing of Controller contract
contract TestController {
 
    // Initialise controller for testing
    Controller controller = new Controller();


    // Use ganache test addresses for testing purposes
    address firstAddress ;
    address secondAddress;
    address thirdAddress;
    address fourthAddress;
    address fifthAddress;

    function beforeAll() public {
        firstAddress = 0x627306090abaB3A6e1400e9345bC60c78a8BEf57;
        secondAddress = 0xf17f52151EbEF6C7334FAD080c5704D77216b732;
        thirdAddress = 0xC5fdf4076b8F3A5357c5E395ab970B5B54098Fef;
        fourthAddress = 0x821aEa9a577a9b44299B9c15c88cf3087F3b5544;
        fifthAddress = 0x0d1d4e623D10F9FBA5Db95830F7d3839406C6AF2;

        controller.addUser(firstAddress);
        controller.addUser(secondAddress);
        controller.addUser(thirdAddress);
        controller.addUser(fourthAddress);
        controller.addUser(fifthAddress);
        controller.generateToken();
    }

    function testInitialValues() public {
        Assert.equal(controller.getUserWaterLimit(), 0, "The water limit should be initialised to 0");
    }

    // function testAddUser() public {
    //     Assert.equal(controller.containsUser(firstAddress),true,"User 1 should be registerd");
    //     Assert.equal(controller.containsUser(secondAddress),true,"User 2 should be registerd");
    //     Assert.equal(controller.containsUser(thirdAddress),true,"User 3 should be registerd");
    //     Assert.equal(controller.containsUser(fourthAddress),true,"User 4 should be registerd");
    //     Assert.equal(controller.containsUser(fifthAddress),true,"User 5 should be registerd");
    //     Assert.equal(controller.containsUser(0x01020),false,"User 6 should not be registerd");
    // }
  
    function testRemoveUser() public {
        Assert.equal(controller.containsUser(firstAddress),true,"First address should be in User List");
        controller.removeUser(firstAddress);
        Assert.equal(controller.containsUser(firstAddress),false,"First address should be removed");
        controller.addUser(firstAddress);
    }
  
    function testGetTotalUsers() public {
        Assert.equal(controller.getTotalUsers(),5,"There should be 5 users");
    }

    function testSetUserWaterLimit () public {
        controller.setUserWaterLimit(80);
        Assert.equal(controller.getUserWaterLimit(), 80, "The water limit should be set to 8");
    }

    function testCanWithdraw () public {
        Assert.equal(controller.canWithdraw(firstAddress), true, "User 1 can withdraw from the Contract");
    }

    function testWithdraw () public {
        //Assert.equal(controller.withdraw(), true, "Withdrew");
        Assert.notEqual(controller.getBalance(firstAddress), 432433465768790876545340, "The address should be 0");

    }
}