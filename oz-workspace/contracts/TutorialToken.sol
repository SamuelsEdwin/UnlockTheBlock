pragma solidity ^0.4.17;

import "zeppelin-solidity/contracts/token/ERC20/StandardToken.sol";

contract TutorialToken is StandardToken {
    string public name = "TutorialToken";
    string public symbol = "TT";
    uint8 public decimals = 2;
    uint public INITIAL_SUPPLY = 12000;
    address owner;
    

    function TutorialToken() public {
    totalSupply_ = INITIAL_SUPPLY;
    balances[msg.sender] = INITIAL_SUPPLY;
    owner = msg.sender;
    }

    function increasedSupply (uint amount) public {
        require(msg.sender == owner);
        totalSupply_ += amount;

    }

    function setSupply (uint amount) public {
        require(msg.sender == owner);
        totalSupply_ = amount;
    }

}