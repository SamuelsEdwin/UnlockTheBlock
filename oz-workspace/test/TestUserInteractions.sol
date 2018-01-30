import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/H2ICO.sol";

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
      uint firstIndex = 0;
      uint secondIndex = 1;
      Assert.equal(token.getUser(firstIndex),firstAddress,"Index 0 should be the first address");
      Assert.equal(token.getUser(secondIndex),secondAddress,"Index 1 should be the second address");
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

  function testDistrubute() public {
      uint supplyAmount = 20000;
      token.setSupply(supplyAmount);

      Assert.equal(token.balanceOf(firstAddress),4000,"Tokens should be the total supply over total amount");
      Assert.equal(token.balanceOf(firstAddress),token.balanceOf(secondAddress),"Tokens should be dvided equally");

  }

}