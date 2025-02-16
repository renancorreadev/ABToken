// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.20;

error Unauthorized();
error TransferNotAllowed(address from, address to, uint256 amount);

error AddressFrozenError(address user);

error TokenPaused();
