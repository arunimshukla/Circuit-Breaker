# Circuit-Breaker

A test Solidity smart contract circuit breaker implementation in production.

![image](https://github.com/user-attachments/assets/48ee4438-9391-4b5c-878a-5bf44bc8f62f)

# Overview

The CircuitBreaker is an Ethereum-based smart contract designed to provide an on-chain circuit breaker mechanism. It aims to enhance the security of decentralized applications (dApps) by automatically pausing the contract in case of potential exploits. This contract is particularly useful for DeFi projects and other high-value smart contract systems where quick response to anomalies is required.

# Features

- **Automatic Pausing**: The contract automatically pauses itself if potential exploit conditions are detected.

- **Customizable Thresholds**: Easily adjust transaction limits and value thresholds.

- **Developer Alerts**: Emits events for potential exploits and allows custom alerts to be sent.

- **Manual Controls**: Includes functions for manual pausing and unpausing by the contract owner.

- **Integratable**: Designed to be easily integrated with existing smart contract functions.

# Exploit Detection Mechanisms

The contract monitors for three main types of potential exploits:

1. **Transaction Frequency**: Detects if too many transactions occur within a single block.

2. **Large Transactions**: Identifies individual transactions that exceed a maximum value threshold.

3. **High Block Value**: Monitors the total value of transactions within a block, pausing if it exceeds a set limit.

# Contract Structure

- `CircuitBreaker`: Main contract inheriting from `Pausable` and `Ownable`.

- Key Functions:

  - `checkAndUpdateCircuitBreaker`: Core function for exploit detection.

  - `resetCounters`: Resets transaction counters on new blocks.

  - `pause` and `unpause`: Manual control functions (owner only).

  - `sendAlert`: Allows the owner to send custom alerts.

  - `someFunction` and `transfer`: Example functions demonstrating integration.

# Setup and Deployment

### Prerequisites

- Node.js and npm installed.

- Truffle or Hardhat for Ethereum development.

- OpenZeppelin Contracts library.

### Installation

1. Clone the repository:

```
   git clone https://github.com/arunimshukla/circuit-breaker.git
   
  ```
   ```
   cd circuit-breaker
  
```

2. Install dependencies:

   ```
   npm install @openzeppelin/contracts
   ```

3. Compile the contract:

   ```
   truffle compile
   ```
   or
   ```
   npx hardhat compile
   ```

4. Deploy the contract:

   ```
   truffle migrate
   ```
   or
   ```
   npx hardhat run scripts/deploy.js
   ```

# Usage

1. After deployment, the contract owner can adjust the threshold constants if needed.

2. Integrate the `checkAndUpdateCircuitBreaker` function into your existing contract functions:

   ```solidity

   function yourFunction() external payable whenNotPaused {
       checkAndUpdateCircuitBreaker(msg.value);
       // Your function logic here
   }

   ```

3. The contract will automatically pause if any exploit conditions are met.

4. Monitor emitted events (`ExploitDetected` and `AlertSent`) for real-time notifications.

5. The owner can manually pause/unpause the contract and send custom alerts as needed.

# Security Considerations

- Regularly review and adjust the threshold values based on your project's needs and network conditions.

- Ensure that only trusted addresses have owner privileges.

- Consider implementing a time-delay mechanism for unpausing to allow for thorough checks before resuming operations.
  
- Regularly audit the contract and any integrated systems for potential vulnerabilities.

# Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

# License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.

# Disclaimer

This smart contract is provided as-is. While it includes security features, it should be thoroughly audited and tested before use in any production environment. The developer assume no liability for any losses or damages incurred through the use of this contract.
