// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {IIdentityRegistry} from "./interfaces/IIdentityRegistry.sol";
import {ICompliance} from "./interfaces/ICompliance.sol";
import {IERC3643} from "./interfaces/IERC3643.sol";

import {Unauthorized, TransferNotAllowed, TokenPaused, AddressFrozenError} from "./Errors/ABTokenErrors.sol";

contract ABToken is ERC20, Ownable, IERC3643 {
    IIdentityRegistry public identityRegistry;
    ICompliance public compliance;
    bool public paused;
    mapping(address => bool) public frozenAddresses;
    mapping(address => uint256) public frozenTokens;

    constructor(string memory name, string memory symbol, address _identityRegistry, address _compliance)
        ERC20(name, symbol)
    {
        identityRegistry = IIdentityRegistry(_identityRegistry);
        compliance = ICompliance(_compliance);
    }

    modifier notPaused() {
        if (paused) revert TokenPaused();
        _;
    }

    modifier notFrozen(address user) {
        if (frozenAddresses[user]) {
            revert AddressFrozenError(user);
        }
        _;
    }

    function setIdentityRegistry(address _identityRegistry) external onlyOwner {
        identityRegistry = IIdentityRegistry(_identityRegistry);
        emit IdentityRegistryAdded(_identityRegistry);
    }

    function setCompliance(address _compliance) external onlyOwner {
        compliance = ICompliance(_compliance);
        emit ComplianceAdded(_compliance);
    }

    function pause() external onlyOwner {
        paused = true;
        emit Paused();
    }

    function unpause() external onlyOwner {
        paused = false;
        emit Unpaused();
    }

    function freezeAddress(address _userAddress, bool _freeze) external onlyOwner {
        frozenAddresses[_userAddress] = _freeze;
        emit AddressFrozen(_userAddress, _freeze);
    }

    function freezeTokens(address _userAddress, uint256 _amount) external onlyOwner {
        frozenTokens[_userAddress] += _amount;
        emit TokensFrozen(_userAddress, _amount);
    }

    function unfreezeTokens(address _userAddress, uint256 _amount) external onlyOwner {
        require(frozenTokens[_userAddress] >= _amount, "Not enough frozen tokens");
        frozenTokens[_userAddress] -= _amount;
        emit TokensUnfrozen(_userAddress, _amount);
    }

    function _beforeTokenTransfer(address from, address to, uint256 amount)
        internal
        override
        notPaused
        notFrozen(from)
    {
        if (!compliance.isTransferAllowed(from, to, amount)) {
            revert TransferNotAllowed(from, to, amount);
        }
        super._beforeTokenTransfer(from, to, amount);
    }
}
