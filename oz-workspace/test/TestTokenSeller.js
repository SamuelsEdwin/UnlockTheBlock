const TokenSellerFactory = artifacts.require('./TokenSellerFactory.sol');
const TokenSeller = artifacts.require('./TokenSeller');
const Token = artifacts.require('./H2ICO');
const Controller = artifacts.require('./Controller');

contract('TokenSeller',function(accounts) {
    let mTokenSeller;
    let mToken;
<<<<<<< HEAD
=======
    //TokenSeller(address _asset, uint _sellPrice, uint _units, bool _sellsTokens)
>>>>>>> e3c75b2e05e0004c08cd0c862286baa34e14056a
    let asset;
    let tokenSellerAddress;
    var sellPrice;//sell price in ether for lot
    var units;
    var sellsTokens;
    var otherAsset;
    let mControl

    beforeEach(async () => {
        mToken = await Token.new();
        asset = await mToken.address;
<<<<<<< HEAD
        sellPrice = 10;
        units = 100;
        sellsTokens = true;
        mTokenSeller = await TokenSeller.new(asset, sellPrice, units, sellsTokens);
        tokenSellerAddress = await mTokenSeller.address;
        mControl = await Controller.new();
        await mControl.setTokenAddr(asset);
        await mControl.setUserWaterLimit(units,{from: accounts[0]});
=======

        
        sellPrice = 2;
        units = 50;
        sellsTokens = true;
        
        mTokenSeller = await TokenSeller.new(asset, sellPrice, units, sellsTokens);
        tokenSellerAddress = await mTokenSeller.address;
        mControl = await Controller.new();
        await  mControl.setTokenAddr(asset);
        await mControl.setUserWaterLimit(units,{from: accounts[0]});
        
     
>>>>>>> e3c75b2e05e0004c08cd0c862286baa34e14056a
    });

    it("All variables should be equal to the values past in by the constructor", async function() {
        let mUnits;
        mUnits = await mTokenSeller.units();
<<<<<<< HEAD
=======

>>>>>>> e3c75b2e05e0004c08cd0c862286baa34e14056a
        let mAsset;
        mAsset = await mTokenSeller.asset();
        assert.equal(mUnits.toNumber(),units,"units should match  constructor parameter");
        assert.equal(mAsset,asset,"asset should match token address in  constructor parameter");
<<<<<<< HEAD
        assert.notEqual(mUnits,units-1,"units should not match  constructor parameter");
        assert.notEqual(mTokenSeller.sellsTokens(),false,"sellPrice should not match  constructor parameter");
        assert.notEqual(mAsset,accounts[1],"asset should not match token address in  constructor parameter");
        assert.notEqual(mAsset,0x0,"asset should not match token address in constructor parameter");        
    });

    it("Contract must be closed for sale", async function() {
        mTokenSeller.activate(false);
        let v = await mTokenSeller.sellsTokens();
        assert.equal(v,false,"contract is still active");       
    });
=======
       // assert.equal(mTokenSeller.sellsTokens,true,"Should Sell tokens");
       // assert.equal(mTokenSeller.sellPrice,sellPrice,"sellPrice should match  constructor parameter");
        
        //false checks
        
        // assert.notEqual(mTokenSeller.sellsTokens,false,"Should not sell tokens");
        assert.notEqual(mUnits,units-1,"units should not match  constructor parameter");
        // assert.notEqual(mTokenSeller.sellPrice,sellPrice+1,"sellPrice should not match  constructor parameter");
        assert.notEqual(mAsset,accounts[1],"asset should not match token address in  constructor parameter");

        assert.notEqual(mAsset,0x0,"asset should not match token address in  constructor parameter");

        
        
    });

    it("All active sellers set to false", async function() {
        let set;
        set = await mTokenSeller.activate(false);
        let get;
        get = await mTokenSeller.sellsTokens();

        assert.equal(false,get.valueOf(),"Should be false");
        assert.notEqual(true,get.valueOf(),"Should not be true");
        
    });

    it("All active sellers set to true", async function() {
        let set;
        set = await mTokenSeller.activate(true);
        let get;
        get = await mTokenSeller.sellsTokens();

        assert.equal(true,get.valueOf(),"Should be true");
        assert.notEqual(false,get.valueOf(),"Should not be false");
        
    });

    // function makerWithdrawAsset(uint tokens) public onlyOwner returns (bool confirm) {
       
       it("makerWithdraw", async function() {
        await mControl.addUser(accounts[1],{from: accounts[0]});
        await mControl.withdraw({from: accounts[1]});
        await mToken.transfer(tokenSellerAddress,40,{from: accounts[1]});
        var withdrawAmount = 5;
        let get;
        get = await mTokenSeller.makerWithdrawAsset(withdrawAmount,{from: accounts[0]});
        
        let mTokenSellerBalance;
        mTokenSellerBalance = await mToken.balanceOf(tokenSellerAddress);
        let userOneBalance;
        userOneBalance = await mToken.balanceOf(accounts[1]); 
        let mUnits;
        mUnits = await mTokenSeller.units();
        assert.equal(mUnits.toNumber(),userOneBalance.toNumber(),"asset should be 'withdrawAmount' less" );
        //assert.notEqual(mUnits.toNumber(),units,"asset should not be unchanged");
    });


>>>>>>> e3c75b2e05e0004c08cd0c862286baa34e14056a
});