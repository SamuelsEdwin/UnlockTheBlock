import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/H2ICO.sol";
import "../contracts/Date/DateTime.sol";
import "../contracts/Date/api.sol";

contract TestUserInteractions {
 
  H2ICO token = new H2ICO();

      address firstAddress ;
      address secondAddress;
      address thirdAddress;
      address forthAddress;
      address fithAddress;
  function beforeAll() public {
      firstAddress = 0x627306090abaB3A6e1400e9345bC60c78a8BEf57;
      secondAddress = 0xf17f52151EbEF6C7334FAD080c5704D77216b732;
      thirdAddress = 0xC5fdf4076b8F3A5357c5E395ab970B5B54098Fef;
      forthAddress = 0x821aEa9a577a9b44299B9c15c88cf3087F3b5544;
      fithAddress = 0x0d1d4e623D10F9FBA5Db95830F7d3839406C6AF2;

      token.addUser(firstAddress);
      token.addUser(secondAddress);
      token.addUser(thirdAddress);
      token.addUser(forthAddress);
      token.addUser(fithAddress);
      
  }

 
  function testAddUser() public {
     
      Assert.equal(token.containsUser(firstAddress),true,"User 1 should be registerd");
      Assert.equal(token.containsUser(secondAddress),true,"User 2 should be registerd");
      Assert.equal(token.containsUser(thirdAddress),true,"User 3 should be registerd");
      Assert.equal(token.containsUser(forthAddress),true,"User 4 should be registerd");
      Assert.equal(token.containsUser(fithAddress),true,"User should not be registerd");
      Assert.equal(token.containsUser(0x01020),false,"User should not be registerd");

      
  }
  function testRemoveUser() public {
      Assert.equal(token.containsUser(firstAddress),true,"First address should be in User List");
      token.removeUser(firstAddress);
      Assert.equal(token.containsUser(firstAddress),false,"First address should be removed");
      token.addUser(firstAddress);
  }
  
  function testGetTotalUsers() public {
      Assert.equal(token.getTotalUsers(),5,"There should be 5 users");
  }

 

}