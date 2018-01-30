pragma solidity ^0.4.17;

import "zeppelin-solidity/contracts/token/ERC20/StandardToken.sol";
import "./Date/DateTime.sol";
import "./Date/api.sol";

contract H2ICO is StandardToken {

    
    struct Date {
        uint8 month;
        uint16 year;
    }

    string private name = "H2ICO";
    string private symbol = "kl";
    uint8 private decimals = 3;
    uint private INITIAL_SUPPLY = 0;
    address private owner;
    uint private userCounter =0;
    uint private userWaterLimit;
    DateTime date = new DateTime();//on main network call actual contract
    
    mapping (address=>bool) validatingMap;
    mapping (address => uint) lastPurchaseDate;
    
     modifier isOwner {
        if (msg.sender == owner) {
            _;
        }
    }

    function H2ICO() public {
        totalSupply_ = INITIAL_SUPPLY;
        balances[msg.sender] = INITIAL_SUPPLY;
        owner = msg.sender;
        userWaterLimit = 0;
    }

    function increasedSupply (uint _amount) public isOwner returns(uint) {
        
        totalSupply_ += _amount;
        return totalSupply_;

    }

    function setSupply (uint _amount) public isOwner {
        balances[owner] = _amount;
        totalSupply_ = _amount;
        
    }
    function setUserWaterLimit(uint _limit) public isOwner {
        userWaterLimit = _limit;
    }

    function addUser(address _user)  public isOwner {
        
        validatingMap[_user] = true;
        userCounter++;
    }
    function getTotalUsers() public constant returns (uint) {
        return userCounter;  
    }
    function withdraw(address _user) public isOwner {
        require(validatingMap[_user]);
        transferFrom(owner, _user, userWaterLimit);

    }
   
    function containsUser(address _user) public view returns(bool) {
        return validatingMap[_user];
        
    }
    function removeUser(address _user)public isOwner {
        validatingMap[_user] = false;
        userCounter--;
    }

    function getDate() public view returns(Date) {
        Date memory rtrDate;
        uint timeStamp = now;
        rtrDate.month = date.getMonth(timeStamp);
        rtrDate.year = date.getYear(timeStamp);
        return rtrDate;
    }

}