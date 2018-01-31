const TokenSellerFactory = artifacts.require('./TokenSellerFactory.sol');
const TokenSeller = artifacts.require('./TokenSeller');
const Token = artifacts.require('./H2ICO');
const Controller = artifacts.require('./Controller');

contract('TokenSeller',function(accounts) {
    let mTokenSeller;
    let mToken;
    //TokenSeller(address _asset, uint _sellPrice, uint _units, bool _sellsTokens)
    let asset;
    var sellPrice;//sell price in ether for lot
    var units;
    var sellsTokens;
    var otherAsset;
    
    beforeEach(async () => {
        mToken = await Token.new();
        asset = await mToken.address;
        sellPrice = 2;
        units = 50;
        sellsTokens = true;
        
        mTokenSeller = await TokenSeller.new(asset, sellPrice, units, sellsTokens);
    });

    it("All variables should be equal to the values past in by the constructor", async function() {
        let mUnits;
        mUnits = await mTokenSeller.units();

        let mAsset;
        mAsset = await mTokenSeller.asset();
        assert.equal(mUnits.toNumber(),units,"units should match  constructor parameter");
        assert.equal(mAsset,asset,"asset should match token address in  constructor parameter");
       // assert.equal(mTokenSeller.sellsTokens,true,"Should Sell tokens");
       // assert.equal(mTokenSeller.sellPrice,sellPrice,"sellPrice should match  constructor parameter");
        
        //false checks
        
        // assert.notEqual(mTokenSeller.sellsTokens,false,"Should not sell tokens");
        // assert.notEqual(mTokenSeller.units,units-1,"units should not match  constructor parameter");
        // assert.notEqual(mTokenSeller.sellPrice,sellPrice+1,"sellPrice should not match  constructor parameter");
        assert.notEqual(mAsset,accounts[1],"asset should not match token address in  constructor parameter");

        assert.notEqual(mAsset,0x0,"asset should not match token address in  constructor parameter");

        
        
    });


});