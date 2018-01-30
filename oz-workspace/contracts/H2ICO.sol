pragma solidity ^0.4.17;

import "zeppelin-solidity/contracts/token/ERC20/MintableToken.sol";
import "./Date/DateTime.sol";
import "./Date/DateTimeAPI.sol";

contract H2ICO is MintableToken {
    
    string private name = "H2ICO";
    string private symbol = "kl";
    uint8 private decimals = 3;
    uint private INITIAL_SUPPLY = 0;
    address private owner;

    /*
        Description: Constructor for Token, generates a token with total supply of 0
        and makes the deployer/issuer of the contract the owner.
        User water limit set to 0
    */
    function H2ICO() public {
        totalSupply_ = INITIAL_SUPPLY;
        balances[msg.sender] = INITIAL_SUPPLY;
        owner = msg.sender;
    }
}