# BitPredict 📈

**BitPredict** is a decentralized, trustless prediction market platform built on the [Stacks](https://www.stacks.co/) blockchain. Users can stake STX tokens to predict whether Bitcoin (BTC) will go **up** or **down** within a specified time frame — and earn proportional rewards for correct predictions.

## 🚀 Features

- 🕒 **Time-Locked Markets**: Predict BTC price direction within specific time windows
- 🔮 **Directional Betting**: Stake STX tokens on “up” or “down” outcomes
- ⛓️ **Oracle-Based Resolution**: Price resolution via authorized off-chain oracle
- 💸 **Reward Distribution**: Automated payouts with proportional reward allocation
- 🧾 **Transparent Fees**: Configurable platform fee with owner withdrawal support
- 🔐 **Non-Custodial & Secure**: Built on Clarity smart contracts with strict permissioning

## 🧱 System Architecture

```plaintext
+--------------------+              +-------------------+
|    End Users       |              |   Oracle Service  |
| (Predictors/DApp)  |              | (Price Feed)      |
+--------+-----------+              +---------+---------+
         |                                    |
         | 1. Make Predictions                |
         +----------------------------------->|
         |                                    |
         | 2. Oracle Resolves Outcome         |
         |<-----------------------------------+
         |                                    |
         | 3. Users Claim Rewards             |
         +----------------------------------->|
         |                                    |
+--------v-----------+              +---------v---------+
| BitPredict Smart   |<------------>| STX Blockchain    |
| Contracts (Clarity)|              | (Stacks L1)       |
+--------------------+              +-------------------+
````

## ⚙️ Smart Contract Overview

### 🔢 Key Constants & Variables

* `contract-owner`: Admin/owner of the contract
* `oracle-address`: Trusted oracle address
* `minimum-stake`: Entry barrier for predictions
* `fee-percentage`: Platform fee (% of reward pool)
* `market-counter`: Auto-incrementing market ID

### 🗃️ Storage Maps

* `markets`: Metadata and parameters for each prediction market
* `user-predictions`: User participation, direction, and claim status

## 🔧 Core Functions

### ✅ Public

```clarity
(create-market start-price start-block end-block)
(make-prediction market-id prediction stake)
(resolve-market market-id end-price)
(claim-winnings market-id)
````

```markdown
```

### 🧾 Read-Only

```clarity
(get-market market-id)
(get-user-prediction market-id user)
(get-contract-balance)
```

### ⚙️ Admin

```clarity
(set-oracle-address address)
(set-minimum-stake amount)
(set-fee-percentage percent)
(withdraw-fees amount)
```

## 💻 Development Setup

### Requirements

* [Clarinet](https://docs.stacks.co/write-smart-contracts/clarinet/overview) v2.0+
* Node.js 18.x
* Hiro or Xverse Wallet (Testnet)

### Installation

```bash
git clone https://github.com/yourorg/bitpredict-contracts
cd bitpredict
clarinet install
npm install -g @stacks/cli
```

### Run Tests

```bash
clarinet test --watch
```

## 📄 Example Workflow

### 1. Market Creation (Admin)

```clarity
(create-market u50000 u725000 u730000)
;; Market for BTC @ $50k from block 725000 to 730000
```

### 2. User Prediction

```clarity
(make-prediction u1 "up" u5000000)
;; 5 STX bet on price going up
```

### 3. Oracle Resolution

```clarity
(resolve-market u1 u51200)
;; Oracle sets ending price as $51,200
```

### 4. Claiming Winnings

```clarity
(claim-winnings u1)
```

## 🧪 Usage Examples

### Fetch Market Info

```clarity
(contract-call? .bitpredict get-market u1)
```

### Fetch User Prediction

```clarity
(contract-call? .bitpredict get-user-prediction u1 'ST123...')
```

### Calculate Potential Returns (JS)

```ts
const calculateReturns = (userStake, totalPool, feePercent, winningPool) => {
  const gross = (userStake * totalPool) / winningPool;
  return gross * (1 - feePercent / 100);
};
```

## 🧯 Error Codes

| Code | Error                    | Description                         |
| ---- | ------------------------ | ----------------------------------- |
| u100 | `err-owner-only`         | Restricted to contract owner        |
| u101 | `err-not-found`          | Market or resource not found        |
| u102 | `err-invalid-prediction` | Invalid direction type              |
| u103 | `err-market-closed`      | Market inactive or already resolved |
| u104 | `err-already-claimed`    | Reward already claimed              |
| u105 | `err-insufficient-funds` | Not enough STX for operation        |
| u106 | `err-invalid-parameter`  | Invalid input                       |

## Security & Trust Model

### Assumptions

* **Oracle Trust**: Single authorized oracle resolves markets
* **Admin Control**: Owner sets oracle, fees, and market parameters
* **Blockchain Security**: Inherits finality and auditability from Stacks (Bitcoin L1)

### Protections

* Markets time-locked for fairness
* Oracle restricted to specific address
* Reward claims single-use (prevents double-spending)
* STX transfers validated against contract balance
* Input boundaries strictly enforced

## Contributing

We welcome PRs, issues, and suggestions!
For large changes, please open an issue first to discuss the proposal.
