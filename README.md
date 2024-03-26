# Personal Bank Account DApp

## Description

This project is a decentralized application (DApp) allowing users to deposit and withdraw Ether to and from a personal bank account smart contract. It's built using Solidity, Next.js, and integrates with MetaMask for Ethereum transactions.

## Features

- Connect to MetaMask wallet
- Display current ETH balance stored in the smart contract for the connected account
- Deposit ETH into the smart contract
- Withdraw all deposited ETH from the smart contract

## Technologies Used

- Solidity for the smart contract
- Next.js for the frontend
- thirdweb SDK for interacting with Ethereum blockchain
- ethers.js for Ethereum wallet management and utilities

## Setup

To run this project locally, follow these steps:

### Prerequisites

- Node.js installed
- MetaMask extension installed in your browser

### Installation

1. Clone the repository:
  ```
  git clone https://github.com/MihRazvan/simple_BankAccount
  ```
2. Navigate to the project directory:
   ```
   cd personal-bank-account-dapp
   ```
3. Install dependencies:
   ```
   npm install
   ```
4. Start the development server
   ```
   npm run dev
   ```
The application should now be running on http://localhost:3000.

Smart Contract Deployment
To deploy the smart contract to a local or test Ethereum network, you'll need:

Compile the smart contract using Hardhat or Truffle
Deploy the smart contract to your chosen network
Update the CONTRACT_ADDRESS in the constants/addresses.js file with your deployed contract's address
Usage
Open the application in your browser
Connect your MetaMask wallet by clicking the "Connect Wallet" button
Enter an amount of ETH to deposit and click "Deposit"
To withdraw your balance, click "Withdraw All"
Contributing
Contributions are welcome! Please feel free to submit a pull request.

License
This project is open source and available under the MIT License.
   
