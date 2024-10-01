// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract CircuitBreaker is Pausable, Ownable {
    uint256 public constant MAX_TRANSACTIONS_PER_BLOCK = 100;
    uint256 public constant MAX_VALUE_PER_TRANSACTION = 1000 ether;
    uint256 public constant MAX_TOTAL_VALUE_PER_BLOCK = 5000 ether;

    uint256 public transactionCount;
    uint256 public totalValue;
    uint256 public lastResetBlock;

    event ExploitDetected(string reason);
    event AlertSent(address indexed sender, string message);

    constructor() {
        lastResetBlock = block.number;
    }

    function resetCounters() internal {
        if (block.number > lastResetBlock) {
            transactionCount = 0;
            totalValue = 0;
            lastResetBlock = block.number;
        }
    }

    function checkAndUpdateCircuitBreaker(uint256 value) internal {
        resetCounters();

        transactionCount++;
        totalValue += value;

        if (transactionCount > MAX_TRANSACTIONS_PER_BLOCK) {
            emit ExploitDetected("Too many transactions in a single block");
            _pause();
        }

        if (value > MAX_VALUE_PER_TRANSACTION) {
            emit ExploitDetected("Transaction value exceeds maximum allowed");
            _pause();
        }

        if (totalValue > MAX_TOTAL_VALUE_PER_BLOCK) {
            emit ExploitDetected("Total value in block exceeds maximum allowed");
            _pause();
        }
    }

    function someFunction() external payable whenNotPaused {
        checkAndUpdateCircuitBreaker(msg.value);
        // Your function logic here
    }

    function pause() external onlyOwner {
        _pause();
    }

    function unpause() external onlyOwner {
        _unpause();
    }

    function sendAlert(string memory message) external onlyOwner {
        emit AlertSent(msg.sender, message);
    }

    // Example of how to integrate with other functions
    function transfer(address payable recipient, uint256 amount) external payable whenNotPaused {
        checkAndUpdateCircuitBreaker(amount);
        recipient.transfer(amount);
    }
}
