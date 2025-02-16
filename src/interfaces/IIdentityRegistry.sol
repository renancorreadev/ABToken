// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/** @dev this interface is used to register the identity of the user */
interface IIdentityRegistry {
    event IdentityRegistered(address indexed userAddress, bytes32 identityHash);
    event IdentityRemoved(address indexed userAddress);
    
    function registerIdentity(address _userAddress, bytes32 _identityHash) external;
    function removeIdentity(address _userAddress) external;
    function isVerified(address _userAddress) external view returns (bool);
    function getIdentity(address _userAddress) external view returns (bytes32);
}
