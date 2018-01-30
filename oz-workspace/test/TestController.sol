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
    }

    function testAddUser() public {
        Assert.equal(controller.containsUser(firstAddress),true,"User 1 should be registerd");
        Assert.equal(controller.containsUser(secondAddress),true,"User 2 should be registerd");
        Assert.equal(controller.containsUser(thirdAddress),true,"User 3 should be registerd");
        Assert.equal(controller.containsUser(forthAddress),true,"User 4 should be registerd");
        Assert.equal(controller.containsUser(fithAddress),true,"User 5 should be registerd");
        Assert.equal(controller.containsUser(0x01020),false,"User 6 should not be registerd");
    }
  
    function testRemoveUser() public {
        Assert.equal(controller.containsUser(firstAddress),true,"First address should be in User List");
        controller.removeUser(firstAddress);
        Assert.equal(controller.containsUser(firstAddress),false,"First address should be removed");
        controller.addUser(firstAddress);
    }
  
    function testGetTotalUsers() public {
        Assert.equal(token.getTotalUsers(),5,"There should be 5 users");
    }

    function testSetUserWaterLimit () public {
        controller.setUserWaterLimit(8);
        Assert.equal(controller.getUserWaterLimit(), 8, "The water limit should be set to 8");
    }
}