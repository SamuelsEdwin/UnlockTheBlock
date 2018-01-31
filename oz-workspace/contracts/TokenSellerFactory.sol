pragma solidity ^0.4.18;

import "../node_modules/zeppelin-solidity/contracts/ownership/Ownable.sol";
import "zeppelin-solidity/contracts/token/ERC20/StandardToken.sol";
import "./TokenSeller.sol";

/**
 * TO DO: Fix interface to include inherited contracts to remove compile error for modified functions 
 */

//  contract TokenSellerInterface {
//      function TokenSeller(address _asset, uint _sellPrice, uint _units , bool _sellsTokens);
//      function activate(bool _sellsTokens) public onlyOwner;      //error with functions having modifiers
//      function makerWithdrawAsset(uint tokens) public onlyOwner returns (bool confirm);
//      function makerWithdrawERC20Token(address tokenAddress, uint amount) public onlyOwner returns (bool confirm);
//      function makerWithdrawEther(uint amount) public onlyOwner returns (bool confirm);
//  }


contract TokenSellerFactory is Ownable {

    event TradeListing(address indexed ownerAddress, address indexed tokenSellerAddress,address indexed asset, uint256 sellPrice, uint256 units, bool sellsTokens);
    event OwnerWithdrewERC20Token(address indexed tokenAddress, uint256 tokens);

    mapping (address => bool) _verify;      //mapping to verify address has a smart contract made by factory

    /** Verify Token Seller Contracts
     * Function is called to verify the parameters of a deployed TokenSeller contract
     * @param tradeContract address of contract to be verified
     *
     * @return  valid        did this TokenTraderFactory create the TokenTrader contract?
     * @return  owner        is the owner of the TokenTrader contract
     * @return  asset        is the ERC20 asset address
     * @return  sellPrice    is the sell price in ethers per `units` of asset tokens
     * @return  units        is the number of units of asset tokens
     * @return  sellsTokens  is the TokenTrader contract selling tokens? 
     */
    function verify(address tradeContract) public view returns (bool valid, address owner, address asset, uint sellPrice, uint units, bool sellsTokens) {
        valid = _verify[tradeContract];
        if (valid) {
            TokenSeller t = TokenSeller(tradeContract);
            owner = t.owner();
            asset = t.asset();
            sellPrice = t.sellPrice();
            units = t.units();
            sellsTokens = t.sellsTokens();
        }
    }

    /** Create TokenSeller contract
     * Generates seller smart contracts for use of token sell orders.
     * For example, listing a TokenSeller contract on the network where the 
     * contract will sell H20 tokens at a rate of 170/100000 = 0.0017 ETH per H20 token:
     *    token address   0xa74476443119a942de498590fe1f2454d7d4ac0d
     *    sellPrice       170
     *    units           100000
     *    sellsTokens     true
     * @param token address of token to be traded
     * @param sellPrice price of lot for sale
     * @param units size of a lot
     * @param sellsTokens check if the contract has permission to sell
     */
    function createSaleContract(address token, uint sellPrice, uint units, bool sellsTokens) public returns (address seller) {
        require(token != 0x0);
        require(sellPrice >= 0);
        require(units >= 0);
        seller = new TokenSeller(token, sellPrice, units, sellsTokens);
        _verify[seller] = true;
        TokenSeller(seller).transferOwnership(msg.sender);
        TradeListing(msg.sender, seller, token, sellPrice, units, sellsTokens);
    }

    /** Withdraw any ECR20 token from factory 
     * MAinly used for erroneuos transaction sent to the factory
     *
     */
    function ownerWithdrawERC20Token(address tokenAddress, uint256 tokens) public onlyOwner returns (bool ok) {
        OwnerWithdrewERC20Token(tokenAddress, tokens);
        return StandardToken(tokenAddress).transfer(owner, tokens);
    }


    function () public {
        revert();
    }
}

