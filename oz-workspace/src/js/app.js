App = {
  web3Provider: null,
  contracts: {},

  /**Initialize the page
   * 
   */
  init: function() {
    return App.initWeb3();
  },

  /**Intialize and inject web3 provider
   * 
   */
  initWeb3: function() {
    // Initialize web3 and set the provider to the testRPC.
    if (typeof web3 !== 'undefined') {
      App.web3Provider = web3.currentProvider;
      web3 = new Web3(web3.currentProvider);
    } else {
      // set the provider you want from Web3.providers
      App.web3Provider = new Web3.providers.HttpProvider('http://127.0.0.1:9545');
      web3 = new Web3(App.web3Provider);
    }
    // after intilising web3 we want intialize the contract
    return App.initContract();
  },

  /**
   * Initialise the Contract 
   */
  initContract: function() {
    $.getJSON('Controller.json', function(data) {
      // Get the necessary contract artifact file and instantiate it with truffle-contract.
      var ControllerArtifact = data;
      App.contracts.Controller = TruffleContract(ControllerArtifact);

      // Set the provider for our contract.
      App.contracts.Controller.setProvider(App.web3Provider);

      //TODO: we can retreive what information we need here
      // Use our contract to retieve and mark the adopted pets.
      // return App.getBalances();
    });

    //bind events allows us to set onclick listeners
    return App.bindEvents();
  },

  bindEvents: function() {
    //TODO: write the corresponding event handlers for these events 
    //TODO: write function to be able to show the water limit
    //TODO: write function to show total valid users 

    //$(document).on('click', '#transferButton', App.handleTransfer);
    $(document).on('click', '#setTokenAddressButton', App.handleSetTokenAddress); //TODO: write event
    $(document).on('click', '#generateTokensButton', App.handleGenerateTokens);   //TODO: write event
    $(document).on('click', '#setWaterLimitButton', App.handleSetWaterLimit);     
    $(document).on('click', '#addValidatedUserButton', App.handleAddValidatedUser); 
    $(document).on('click', '#removeUserButton', App.handleRemoveUser);             
    $(document).on('click', '#withDrawTokensButton', App.handleWithDrawTokens);     
    $(document).on('click', '#checkAddressIfCanWithdrawButton', App.handleCheckAddressIfItCanWithDraw); //TODO: write event
    $(document).on('click', '#currentUserTokenBalanceButton', App.handleViewCurrentUserTokenBalance); //TODO: write event
  },

  /**
   * Handle the event for changing the water limit
   */
  handleSetWaterLimit :function(event){
    event.preventDefault();

    //get the account in order to be able to execute function on the blockchain
    //in particular access account[0]
    web3.eth.getAccounts(function(error, accounts) {
    if (error) {
        console.log(error);
    }
    var account = accounts[0];

    //get the water limit from the ui element
    var waterLimit = parseInt($('#waterLimitInput').val());

    //get an instance of the contract
    var controllerInstance;
    App.contracts.Controller.deployed().then(function(instance) {
      controllerInstance = instance;

    // Execute function on smart contract
      return controllerInstance.setUserWaterLimit(waterLimit, {from: account});
      }).then(function(result) {
       
        console.log(result);
       
      }).catch(function(err) {
        console.log(err.message);
      });
    });
  },

  /**
   * Handle the event for adding validated users to the smart contract
   */
  handleAddValidatedUser :function(event){
    event.preventDefault();

    //get access to account 0
    web3.eth.getAccounts(function(error, accounts) {
      if (error) {
        console.log(error);
      }
      var account = accounts[0];

       //pull value off of UI element
       //CAN TAKE THIS VALUE IN AS A STRING AS WEB3 WILL AUTOMATICALLY CAST TO ADDRESS
      var validatedUser = $('#validateUserTextBox').val();
  
       //get an instance of the contract
      var controllerInstance;
      App.contracts.Controller.deployed().then(function(instance) {
      controllerInstance = instance;

      // Execute addUser
      return controllerInstance.addUser(validatedUser, {from: account});
      }).then(function(result) {
        console.log(result);
      
      
      }).catch(function(err) {
        console.log(err.message);
      });
    });
  },

  /**
   * Handle the event to remove a user from the smart contract
   */
  handleRemoveUser :function(event){
    event.preventDefault();

    //get access to accounts[0]
    web3.eth.getAccounts(function(error, accounts) {
      if (error) {
        console.log(error);
      }

      var account = accounts[0];
      //pull value off of UI element
      //IMPLICIT CONVERSION BETWEEN STRING TO ADDR
      var user = $('#removeUserTextBox').val(); 


      //get an instance of the contract
      var controllerInstance;
      App.contracts.Controller.deployed().then(function(instance) {
      controllerInstance = instance;

      // Execute removeUser
      return controllerInstance.removeUser(user, {from: account});
    }).then(function(result) {
     
      console.log(result);
     
     
    }).catch(function(err) {
      console.log(err.message);
    });
      
    });
  },

  /**Allow users to draw their monthly allocation of tokens */
  handleWithDrawTokens :function(event){
    event.preventDefault();

    //get account 0
    web3.eth.getAccounts(function(error, accounts) {
      if (error) {
        console.log(error);
      }
      var account = accounts[0];

      App.contracts.Controller.deployed().then(function(instance) {
        ControllerInstance = instance;

        return ControllerInstance.withdraw({from: account});
      }).then(function(result) {
        console.log(result);
      }).catch(function(err) {
        console.log(err.message);
      });
    });

  },
  /*
  handleTransfer: function(event) {
    event.preventDefault();

    var amount = parseInt($('#TTTransferAmount').val());
    var toAddress = $('#TTTransferAddress').val();

    console.log('Transfer ' + amount + ' TT to ' + toAddress);

    var H2ICOInstance;

    web3.eth.getAccounts(function(error, accounts) {
      if (error) {
        console.log(error);
      }

      var account = accounts[0];

      App.contracts.H2ICO.deployed().then(function(instance) {
        H2ICOInstance = instance;

        return H2ICOInstance.transfer(toAddress, amount, {from: account});
      }).then(function(result) {
        alert('Transfer Successful!');
        return App.getBalances();
      }).catch(function(err) {
        console.log(err.message);
      });
    });
  },
  */
  handleSet: function(event) {
    event.preventDefault();

    var amount = parseInt($('#IncreaseAmount').val());
    

    console.log('Set amount by' + amount );

    var H2ICOInstance;

    web3.eth.getAccounts(function(error, accounts) {
      if (error) {
        console.log(error);
      }

      var account = accounts[0];

      App.contracts.H2ICO.deployed().then(function(instance) {
        H2ICOInstance = instance;

        return H2ICOInstance.setSupply(amount);
      }).then(function(result) {
        alert('Increase Successful!');
        return App.getBalances();
      }).catch(function(err) {
        console.log(err.message);
      });
    });
  },

  getBalances: function(adopters, account) {
    console.log('Getting balances...');

    var H2ICOInstance;

    web3.eth.getAccounts(function(error, accounts) {
      if (error) {
        console.log(error);
      }

      var account = accounts[0];

      App.contracts.H2ICO.deployed().then(function(instance) {
        H2ICOInstance = instance;

        return H2ICOInstance.balanceOf(account);
      }).then(function(result) {
        balance = result.c[0];

        $('#TTBalance').text(balance);
      }).catch(function(err) {
        console.log(err.message);
      });
    });
  }

};

$(function() {
  $(window).load(function() {
    App.init();
  });
});
