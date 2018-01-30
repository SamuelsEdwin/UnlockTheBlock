pragma solidity ^0.4.17;

import "zeppelin-solidity/contracts/token/ERC20/StandardToken.sol";
import "./Date/DateTime.sol";
import "./Date/DateTimeAPI.sol";

contract H2ICO is MintableToken {

    // struct Date {
    //     uint8 month;
    //     uint16 year;
    // }

    string private name = "H2ICO";
    string private symbol = "kl";
    uint8 private decimals = 3;
    uint private INITIAL_SUPPLY = 0;
    address private owner;

    
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
/*
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
/*
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
/*
  function finishMinting() canMint private returns (bool) {
    mintingFinished = true;
    MintFinished();
    return true;
  }
*/
}