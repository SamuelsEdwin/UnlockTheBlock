pragma solidity ^0.4.17;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/H2ICO.sol";
import "../contracts/Date/DateTime.sol";
import "../contracts/Date/DateTimeAPI.sol";

contract TestToken {
 
  H2ICO token = new H2ICO();

  function testOwnerHasInitialValue() public {
      uint expected = 0;
      Assert.equal(token.totalSupply(),expected,"Supply Should have 0 tokens");
    }
}