pragma solidity ^0.4.24;

import "openzeppelin-solidity/contracts/token/ERC20/StandardToken.sol";
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";

contract HarbergerToken is StandardToken, Ownable {
    string public name = "HarbergerToken";
    string public symbol = "HT";
    uint8 public decimals = 2;
    uint public INITIAL_SUPPLY = 120000;
    uint256 public buyPrice;
    uint constant taxRate = 7; // *Fixed* tax rate (7% annual)
    uint taxCollectedBalance; // Current amount of tax collected

    uint public minBalanceForAccounts; //


    struct AskStruct {  
        uint askPrice;			// Price per Token in ETH
		uint tokenBalance;		// Quantity of tokens
		uint etherBalance;		// Quantity of ETH (used for paying tax)
		//uint timeOfLastTax; 		// Last time tax was collected
        bool isValue;
    }

    mapping(address => AskStruct) askOrderBook;

    constructor() public {
        totalSupply_ = INITIAL_SUPPLY;
        balances[msg.sender] = INITIAL_SUPPLY;
    }

    function setBuyPrice(uint256 newBuyPrice) public onlyOwner {
        buyPrice = newBuyPrice;
    }

    function buy() payable public returns (uint amount)  {
        amount = msg.value / buyPrice;                    // calculates the amount
        _transfer(this, msg.sender, amount);
        return amount;
    }


    function setPrice(uint _askPrice) public {
        if(askOrderBook[msg.sender].isValue) {
            askOrderBook[msg.sender].tokenBalance = msg.sender.balance;
            askOrderBook[msg.sender].etherBalance = msg.sender.balance;
        } else {
            askOrderBook[msg.sender] = AskStruct(_askPrice, msg.sender.balance, msg.sender.balance, true);           
        }
    }

    // 
    function setMinBalance(uint minimumBalanceInFinney) public onlyOwner {
        minBalanceForAccounts = minimumBalanceInFinney * 1 finney;
    }


    // add following code to transfer function     
    /*
    function transfer(address _to, uint256 _value) {
        ...
        if(msg.sender.balance < minBalanceForAccounts)
            sell((minBalanceForAccounts - msg.sender.balance) / sellPrice);
    }
    */
}

    

    