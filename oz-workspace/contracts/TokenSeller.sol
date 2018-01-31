pragma solidity ^0.4.18;

import "../node_modules/zeppelin-solidity/contracts/ownership/Ownable.sol";
import "zeppelin-solidity/contracts/token/ERC20/StandardToken.sol";

/*contract ERC20Partial {
    function totalSupply() constant returns (uint totalSupply);
    function balanceOf(address _owner) constant returns (uint balance);
    function transfer(address _to, uint _value) returns (bool success);
    event Transfer(address indexed _from, address indexed _to, uint _value);
}
*/

contract TokenSeller is Ownable {

    address public asset;       //token to be traded
    uint public sellPrice;      //price of the lot
    uint public units;          //lot size

    bool public sellsTokens;    //bool to check if the contract is selling tokens
//    MintableToken public token; 

    event ActivatedEvent(bool sells);           //event trigger to show that a account sells
    event MakerWithdrewAsset(uint256 tokens);   //event trigger when account withdraws a token asset
//    event MakerTransferredAsset(address toTokenSeller, uint256 tokens); //event trigger when account transfers a token asset
    event MakerWithdrewERC20Token(address tokenAddress, uint256 tokens); //event trigger when account withdraws an ERC20 compliant token asset
    event MakerWithdrewEther(uint256 ethers);       //event for when seller account withdraws ether from transaction
    event TakerBoughtAsset(address indexed buyer, uint256 ethersSent, uint256 ethersReturned, uint256 tokensBought);    //event for when buyer account purchases token asset

    /** Constructor Method
     * Constructor should only be called by the TokenSellerFactory contract
     * @param _asset address of token asset to be sold for ether
     * @param _sellPrice  Price sales price of lot 
     * @param _units size of lot 
     * @param _sellsTokens validate that TokenSeller contract has permission to sell from Factory
     */
    function TokenSeller(address _asset, uint _sellPrice, uint _units, bool _sellsTokens) public {
        asset = _asset;
        sellPrice = _sellPrice;
        units = _units;
        sellsTokens = _sellsTokens;
        ActivatedEvent(sellsTokens);
    }

    /** Activate/Deactivate contract sell status
     * Make of the contract can control sell permission of the contract
     * @param _sellsTokens permission variable
     */
    function activate(bool _sellsTokens) public onlyOwner {
        sellsTokens = _sellsTokens;
        ActivatedEvent(sellsTokens);
    }

    /** Withdraw tokens from Contract
     * Contract Owner can withdraw tokens from the contract, essentially decreasing the order to sell
     * @param tokens amount of tokens to be withdrawn from the contract
     * @return confirm confirmation of withdrawal
     */
    function makerWithdrawAsset(uint tokens) public onlyOwner returns (bool confirm) {
        MakerWithdrewAsset(tokens);
        return StandardToken(asset).transfer(owner, tokens);
    }
 
    /** Return Tokens to Contract Maker
     * Used to return tokens accidentally sent for sale, that is, if the incorrect token type was sent.
     * Only permissable for contract owner to perform reversal
     * @param tokenAddress address of token accidentally sent
     * @param amount amount sent to be reversed
     * @return confirm confirmation to ensure function executed
     */
    function makerWithdrawERC20Token(address tokenAddress, uint amount) public onlyOwner returns (bool confirm) {
        MakerWithdrewERC20Token(tokenAddress, amount);
        return StandardToken(tokenAddress).transfer(owner, amount);
    }

    /** Withdraw Ether from Contract
     * Maker can withdraw ether sent to contract for trade. Only can be executed by contract owner.
     * Contract balance is checked to ensure sufficient ether is available for withdrawel.
     * @param amount ether amount to be withdrawn
     * @return confirm transaction confirmation
     */
    function makerWithdrawEther(uint amount) public onlyOwner returns (bool confirm) {
        
        if (this.balance >= amount) {               //check contract balance
            MakerWithdrewEther(amount);
            return owner.send(amount);
        }
        return false;
    }

    /** Taker Purchases Token
     * The taker is able to purchase tokens offered by the contract with thei ether.
     * 
     * TO DO: (1) Remove depreacted 'throw' commands and replace with 'require()' or suitable counterpart
              (2) Fix "else if" parse error
     */
    function takerBuyAsset() payable public {
        if (sellsTokens || msg.sender == owner) {
            // Note that sellPrice has already been validated as > 0
            uint order = msg.value / sellPrice;
            // Note that units has already been validated as > 0
            uint can_sell = StandardToken(asset).balanceOf(address(this)) / units;
            uint change = 0;
            if (msg.value > (can_sell * sellPrice)) {
                change = msg.value - (can_sell * sellPrice);
                order = can_sell;
            }
            if (change > 0) {
                require(msg.sender.send(change));
            }
            if (order > 0) {
                require(StandardToken(asset).transfer(msg.sender, order * units));
            }
            TakerBoughtAsset(msg.sender, msg.value, change, order * units);
        } else {
            // Return user funds if the contract is not selling 
            require(msg.sender.send(msg.value));
        }
    }
    
    /** Fallback function 
     */
    function() payable public {
        takerBuyAsset;
    }

}