// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {IIdentityRegistry} from "./interfaces/IIdentityRegistry.sol";
import {IIdentityRegistryStorage} from "./interfaces/storage/IIdentityRegistryStorage.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @dev this contract is used to register the identity of the user
 */
/**
 * @dev pt-br: este contrato é usado para registrar a identidade do usuário verificado fazendo a ponte entre o ERC3643 e o IdentityRegistryStorage
 */
/// @dev pt-br: esse contrato gerencia a relação entre os usuários e suas identidades verificadas.
contract IdentityRegistry is IIdentityRegistry, Ownable {
    IIdentityRegistryStorage private identityStorage;

    constructor(address _identityStorage) {
        require(_identityStorage != address(0), "Invalid storage address");
        identityStorage = IIdentityRegistryStorage(_identityStorage);
    }

    function registerIdentity(address _userAddress, bytes32 _identityHash) external onlyOwner {
        identityStorage.storeIdentity(_userAddress, _identityHash);
        emit IdentityRegistered(_userAddress, _identityHash);
    }

    function removeIdentity(address _userAddress) external onlyOwner {
        identityStorage.deleteIdentity(_userAddress);
        emit IdentityRemoved(_userAddress);
    }

    function isVerified(address _userAddress) external view returns (bool) {
        return identityStorage.exists(_userAddress);
    }

    function getIdentity(address _userAddress) external view returns (bytes32) {
        return identityStorage.getIdentityHash(_userAddress);
    }
}
