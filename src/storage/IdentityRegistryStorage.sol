// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {IIdentityRegistryStorage} from "../interfaces/storage/IIdentityRegistryStorage.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {
    InvalidAddress, 
    InvalidIdentityHash, 
    IdentityDoesNotExist
} from "../Errors/IdentityRegistryStorageErrors.sol";

/** @dev this contract is used to store the identity of the user */
/** @dev pt-br: este contrato é usado para armazenar a identidade do usuário verificado */
contract IdentityRegistryStorage is IIdentityRegistryStorage, Ownable {
    mapping(address => bytes32) private identities;

    modifier onlyValidAddress(address _userAddress) {
        if (_userAddress == address(0)) revert InvalidAddress();
        _;
    }

    modifier onlyValidIdentity(bytes32 _identityHash) {
        if (_identityHash == bytes32(0)) revert InvalidIdentityHash();
        _;
    }

    modifier identityExists(address _userAddress) {
        if (!exists(_userAddress)) revert IdentityDoesNotExist();
        _;
    }

    function storeIdentity(address _userAddress, bytes32 _identityHash)
        external
        onlyOwner
        onlyValidAddress(_userAddress)
        onlyValidIdentity(_identityHash)
    {
        identities[_userAddress] = _identityHash;
        emit IdentityStored(_userAddress, _identityHash);
    }

    function deleteIdentity(address _userAddress)
        external
        onlyOwner
        identityExists(_userAddress)
    {
        delete identities[_userAddress];
        emit IdentityDeleted(_userAddress);
    }

    function getIdentityHash(address _userAddress) external view returns (bytes32) {
        return identities[_userAddress];
    }

    function exists(address _userAddress) public view returns (bool) {
        return identities[_userAddress] != bytes32(0);
    }
}