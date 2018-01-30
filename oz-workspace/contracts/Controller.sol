pragma solidity ^0.4.17;

import "zeppelin-solidity/contracts/token/ERC20/StandardToken.sol";
import "./Date/DateTime.sol";
import "./Date/DateTimeAPI.sol";


contract Controller {
    address private owner;
    uint private userCounter =0;
    uint private userWaterLimit;
    DateTime date = new DateTime();//on main network call actual contract
    
    mapping (address => bool) validatingMap;
    mapping (address => uint) lastPurchaseDate;


    function Controller () public {
        userWaterLimit = 0;
        owner = msg.sender;
    }
        /*
        Description: Modifier to be used to ensure the sender is in fact the owner
        continues if true, stops executing if false
    */
     modifier isOwner {
        if (msg.sender == owner) {
            _;
        }
    }

    /**
    * Description   Function allowing the owner only to set the water limit per user per month
    * Param _limit  The amount that will be allocated to userWaterLimit for each user
    *
    */

    function setUserWaterLimit(uint _limit) public isOwner {
        userWaterLimit = _limit;
    }

    /**
    * Description   Function allowing returning the current water limit
    * return uint   The allocated Water Limit for each user
    *
    */
    function getUserWaterLimit() public returns (uint) {
        return userWaterLimit;
    }

    /**
    * Description   Function to add user to the list of valid residents.
    *               Modifies a mapping from public address to boolean confirming or denying access
    *               Additionally increases the number of users in the database
    * Param _user   The public key to the users account to be mapped to true
    */
    function addUser(address _user)  public isOwner {
        
        validatingMap[_user] = true;
        userCounter++;
    }

    /**
    * Description   Function returning the number of registered valid users
    * returns uint  No. of users
    */
    function getTotalUsers() public constant returns (uint) {
        return userCounter;  
    }

    /** 
    * Description   Function allowing users to withdraw their monthly allowance from the contract
    *               Tokens are minted according to need and issued to the users
    *               Only valid users are able to withdraw, as well as users are limited to withdrawing
    *               once a month
    * returns       Returns a boolean if the transaction was successful
    */

/* Needs to be modified to work with Tokens
    function withdraw() public returns (bool) {
        require(validatingMap[msg.sender]);
        return transferFrom(owner, msg.sender, userWaterLimit);
    }
/* 

    /**
    * Description    Function confirming whether a user is a valid user in the network
    * Param _user    The address of the user we are willing to determine the validity of
    * returns bool   Returns true or false for valid or invalid   
    */
    function containsUser(address _user) public view returns(bool) {
        return validatingMap[_user];
        
    }


    /**
    * Description   Function allowing the owner of the contract to remove users from the mapping of
    *               valid users and reduces the number of users registered
    * Param _user   Address of the user that is to be removed from the network
    */
    function removeUser(address _user)public isOwner {
        validatingMap[_user] = false;
        userCounter--;
    }

    /**
    * Description   Function to return the current date and time from the now function
    * returns Date  Struct containing a uint value for month and uint value for year
    */
    // function getDate() public view returns(Date) {
    //     Date memory rtrDate;
    //     rtrDate.month = date.getMonth(_timeStamp);
    //     rtrDate.year = date.getYear(_timeStamp);
    //     return rtrDate;
    // }

}