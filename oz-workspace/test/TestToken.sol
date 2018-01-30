pragma solidity ^0.4.17;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/H2ICO.sol";

contract TestToken {
 
  H2ICO token = new H2ICO();

  // Testing the adopt() function
  function testOwnerHasInitialValue() public {
      uint expected = 12000;
      Assert.equal(token.totalSupply(),expected,"Owner Should have 0 tokens");
    }
  
  function testSetSupply() public {
    uint expected = 11000;
    token.setSupply(expected);
    Assert.equal(token.totalSupply(),expected,"Owner Should have 11000 tokens");
    Assert.equal(token.balanceOf(msg.sender),expected,"Owners balance Should be 11000 tokens");
  }



  

}