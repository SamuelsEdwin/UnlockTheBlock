pragma solidity ^0.4.17;

import "zeppelin-solidity/contracts/token/ERC20/StandardToken.sol";
import "./Date/DateTime.sol";
import "./Date/DateTimeAPI.sol";

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
    
    mapping (address => bool) validatingMap;
    mapping (address => uint) lastPurchaseDate;
    
    /*
        Description: Modifier to be used to ensure the sender is in fact the owner
        continues if true, stops executing if false
    */
     modifier isOwner {
        if (msg.sender == owner) {
            _;
        }
    }

    /*
        Description: Constructor for Token, generates a token with total supply of 0
        and makes the deployer/issuer of the contract the owner.
        User water limit set to 0
    */
    function H2ICO() public {
        totalSupply_ = INITIAL_SUPPLY;
        balances[msg.sender] = INITIAL_SUPPLY;
        owner = msg.sender;
        userWaterLimit = 0;
    }

/*
Deprecated, to be confirmed...
    function increasedSupply (uint _amount) public isOwner returns(uint) {
        
        totalSupply_ += _amount;
        return totalSupply_;

    }

    function setSupply (uint _amount) public isOwner {
        balances[owner] = _amount;
        totalSupply_ = _amount;
        
    }

*/ 

event Mint(address indexed to, uint256 amount);
  event MintFinished();

  bool public mintingFinished = false;


  modifier canMint() {
    require(!mintingFinished);
    _;
  }

  /**
   * Description Function to mint tokens
   * Param _to The address that will receive the minted tokens.
   * Param _amount The amount of tokens to mint.
   * return A boolean that indicates if the operation was successful.
   */
  function mint(address _to, uint256 _amount) canMint private returns (bool) {
    totalSupply_ = totalSupply_.add(_amount);
    balances[_to] = balances[_to].add(_amount);
    Mint(_to, _amount);
    Transfer(address(0), _to, _amount);
    return true;
  }

  /**
   * Description Function to stop minting new tokens.
   * return True if the operation was successful.
   */
  function finishMinting() canMint private returns (bool) {
    mintingFinished = true;
    MintFinished();
    return true;
  }

    /**
    * Description Function allowing the owner only to set the water limit per user per month
    * Param _limit The amount that will be allocated to userWaterLimit for each user
    *
    */

    function setUserWaterLimit(uint _limit) public isOwner {
        userWaterLimit = _limit;
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

    function withdraw() public retuens (bool){
        require(validatingMap[msg.sender]);
        return transferFrom(owner, msg.sender, userWaterLimit);
    }
   

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
    function getDate() public view returns(Date) {
        Date memory rtrDate;
        rtrDate.month = date.getMonth(_timeStamp);
        rtrDate.year = date.getYear(_timeStamp);
        return rtrDate;
    }

}