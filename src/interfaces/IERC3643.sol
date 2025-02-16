// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";



/** @dev ERC-3643 */
/**
 * @title ERC-3643
 * @author Renan C. F. Correa
 * @notice ERC-3643 pausar, congelar tokens e gerenciar conformidad
 */
interface IERC3643 {
    event UpdatedTokenInformation(
        string newName,
        string newSymbol,
        uint8 newDecimals,
        string newVersion,
        address newOnchainID
    );

    event IdentityRegistryAdded(address indexed identityRegistry);
    event ComplianceAdded(address indexed compliance);
    event AddressFrozen(address indexed userAddress, bool indexed isFrozen);
    event TokensFrozen(address indexed userAddress, uint256 amount);
    event TokensUnfrozen(address indexed userAddress, uint256 amount);
    event Paused();
    event Unpaused();

    function setIdentityRegistry(address _identityRegistry) external;
    function setCompliance(address _compliance) external;
    function pause() external;
    function unpause() external;
    function freezeAddress(address _userAddress, bool _freeze) external;
    function freezeTokens(address _userAddress, uint256 _amount) external;
    function unfreezeTokens(address _userAddress, uint256 _amount) external;
}