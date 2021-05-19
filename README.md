# Bluebell Life - Smart Contracts

## Requirements
Node Version >= 14

## Usage

#### Install Truffle 
```
npm install -g truffle
```

#### Add your Mnemonic Secret File
- Create a file `.secret`
- Enter your mnemonic words in the file separated by empty space

#### Compile all the contracts
```
truffle compile
```

#### Deploy all the contracts to the [development / testnet / bsc] chain

```
truffle migrate --network testnet
```