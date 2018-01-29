pragma solidity ^0.4.17;

import "zeppelin-solidity/contracts/token/ERC20/StandardToken.sol";

contract H2ICO is StandardToken {
    string private name = "H2ICO";
    string private symbol = "kl";
    uint8 private decimals = 3;
    uint private INITIAL_SUPPLY = 0;
    address private owner;
    
    address[] users;
    
     modifier isOwner {
        if (msg.sender == owner) {
            _;
        }
    }

    function H2ICO() public {
        totalSupply_ = INITIAL_SUPPLY;
        balances[msg.sender] = INITIAL_SUPPLY;
        owner = msg.sender;
    }

    function increasedSupply (uint _amount) public isOwner returns(uint) {
        
        totalSupply_ += _amount;
        return totalSupply_;

    }

    function setSupply (uint _amount) public isOwner {
        
        totalSupply_ = _amount;
        balances[msg.sender] = _amount;
    }

    function addUser(address _user)  public isOwner {
        users.push(_user);
    }

}