// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/** @dev This interface is used to store the identity of the user */
interface IIdentityRegistryStorage {
    event IdentityStored(address indexed userAddress, bytes32 identityHash);
    event IdentityDeleted(address indexed userAddress);

    function storeIdentity(address _userAddress, bytes32 _identityHash) external;
    function deleteIdentity(address _userAddress) external;
    function getIdentityHash(address _userAddress) external view returns (bytes32);
    function exists(address _userAddress) external view returns (bool);
}