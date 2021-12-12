# EthereumBlockchainPath
This is a place in which I keep the current/past projects related to Ethereum Blockchain that I develop for my own study purpose and to share it with recruiters that are interested to find more about my knowledge and motivation.

SolidityContracts project contains some simple contracts that I Implemented in order to get used and learn Solidity.
These contracts were run using the http://remix.ethereum.org/ and the <b>Web3 Provider</b> environment offered by <b>Ganache</b> and interact with <b>Web3.js</b>

SharedWallet contains the necessary Solidity contracts used to retrieve and withdrawl Ethereum on and from an address.
Main behavior is following:
1. A deposit can be made by anybody.
2. The contract owner can do unlimited withdrawals.
3. Non-Owner can do withdrawal based on a allowance variable set by owner.
4. Only owner can change the allowance.
Project was run using the http://remix.ethereum.org/ and the Web3 Provider environment offered by Ganache and interact with Web3.js

SupplyChainTrigger project was created using truffle unbox which downloaded a react project setup in order to interact with smart contracts.
Main behavior is following:
1. Track an Products that costs X in Wei via Blockchain.
2. Only Owner of the contract can create product.
3. Customer sent the amount of Wei to the Product address and a event is triggered.
4. Owner after is informed dispatches the Product to the Customer.
Note that this was made only for test and study purpose is not a valid production version. That's whay the code is not commented properly.
Projects also contains <b>UnitTest</b>.
Project was run using the <b>truffle boxes</b> and the Web3 Provider and interact with <b>Web3.js</b>


These I learned to do after I did the course udemy.com/course/blockchain-developer.
