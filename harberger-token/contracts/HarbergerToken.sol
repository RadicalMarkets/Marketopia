pragma solidity ^0.4.24;

import "openzeppelin-solidity/contracts/token/ERC20/StandardToken.sol";
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";

contract HarbergerToken is StandardToken, Ownable {
    string public name = "HarbergerToken";
    string public symbol = "HT";
    uint8 public decimals = 2;
    uint public INITIAL_SUPPLY = 120000;
    uint constant taxRate = 7; // *Fixed* tax rate (7% annual)
    uint taxCollectedBalance; // Current amount of tax collected


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

    function setPrice(uint _askPrice) public {
        if(askOrderBook[msg.sender].isValue) {
            askOrderBook[msg.sender].tokenBalance = msg.sender.balance;
            askOrderBook[msg.sender].etherBalance = msg.sender.balance;
        } else {
            askOrderBook[msg.sender] = AskStruct(_askPrice, msg.sender.balance, msg.sender.balance, true);           
        }
    }

}