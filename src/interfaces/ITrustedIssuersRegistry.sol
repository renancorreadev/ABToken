// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @dev this interface is used to register the trusted issuers
 */
interface ITrustedIssuersRegistry {
    event TrustedIssuerAdded(address indexed issuer);
    event TrustedIssuerRemoved(address indexed issuer);

    function addTrustedIssuer(address _issuer) external;
    function removeTrustedIssuer(address _issuer) external;
    function verifyIsTrustedIssuer(address _issuer) external view returns (bool);
}
