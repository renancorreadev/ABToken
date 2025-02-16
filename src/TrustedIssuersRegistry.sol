// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ITrustedIssuersRegistry} from "./interfaces/ITrustedIssuersRegistry.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract TrustedIssuersRegistry is ITrustedIssuersRegistry, Ownable {
    address[] private trustedIssuers;
    mapping(address => bool) private isTrustedIssuer;

    error IssuerAlreadyExists(address issuer);
    error IssuerDoesNotExist(address issuer);

    function addTrustedIssuer(address _issuer) external onlyOwner {
        if (isTrustedIssuer[_issuer]) {
            revert IssuerAlreadyExists(_issuer);
        }
        trustedIssuers.push(_issuer);
        isTrustedIssuer[_issuer] = true;
        emit TrustedIssuerAdded(_issuer);
    }

    function removeTrustedIssuer(address _issuer) external onlyOwner {
        if (!isTrustedIssuer[_issuer]) {
            revert IssuerDoesNotExist(_issuer);
        }
        uint256 length = trustedIssuers.length;
        for (uint256 i = 0; i < length; i++) {
            if (trustedIssuers[i] == _issuer) {
                trustedIssuers[i] = trustedIssuers[length - 1];
                trustedIssuers.pop();
                break;
            }
        }
        delete isTrustedIssuer[_issuer];
        emit TrustedIssuerRemoved(_issuer);
    }

    function getTrustedIssuers() external view returns (address[] memory) {
        return trustedIssuers;
    }

    function verifyIsTrustedIssuer(address _issuer) external view returns (bool) {
        return isTrustedIssuer[_issuer];
    }
}
