// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

contract EtherWallet {

    // Mapping to store addresses and the amount of ETH deposited
    mapping(address => uint256) public addressToAmountReceived;

    // Array of addresses who deposited
    address[] public senders;
    
    // The first person to deploy the contract is the owner
    address public owner;

    function received() public payable {
        // Add to mapping and senders array
        addressToAmountReceived[msg.sender] = addressToAmountReceived[msg.sender] + msg.value;
        senders.push(msg.sender);
    }

    modifier onlyOwner {
        // Is the message sender the owner of the contract?
        require(msg.sender == owner, "Only the owner can call this method!");
        _; // The withdraw() function will be inserted here
    }

    // OnlyOwner modifier will first check the condition inside it
    // and if true, the withdraw function will be executed
    function withdraw(uint _amount) external onlyOwner {
        payable(msg.sender).transfer(_amount);
    }

    function currentBalance() external view returns (uint) {
        return address(this).balance;
    }
}
