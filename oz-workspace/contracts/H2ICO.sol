pragma solidity ^0.4.17;

import "zeppelin-solidity/contracts/token/ERC20/StandardToken.sol";

contract H2ICO is StandardToken {
    string private name = "H2ICO";
    string private symbol = "kl";
    uint8 private decimals = 3;
    uint private INITIAL_SUPPLY = 12000;
    address private owner;
    
    address[] users;

    mapping (address=>bool) validatingMap;
    
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
        balances[owner] = _amount;
        totalSupply_ = _amount;
        
    }

    function addUser(address _user)  public isOwner {
        users.push(_user);
        validatingMap[_user] = true;
    }
    function getTotalUsers() public constant returns (uint) {
        return users.length;  
    }
    function distribute() public isOwner {
        uint arrayLength = getTotalUsers();
        for (uint index = 0;index<arrayLength;index++) {
            transferFrom(owner, users[index], uint(balances[msg.sender])/uint(arrayLength));
        }
    }
    function getUser(uint _index) public view returns (address) {
        return users[_index];
    }
    function containsUser(address _user) public view returns(bool) {
        return validatingMap[_user];
        
    }
    function removeUser(address _user)public isOwner {
        validatingMap[_user] = false;
    }

}