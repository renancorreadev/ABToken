// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/** @dev this interface is used to add compliance rules and check if the user is compliant */
/** @dev pt-br: esse contrato é usado para adicionar regras de compliance e verificar se o usuário é compliant */
interface ICompliance {
    event RuleAdded(bytes32 ruleHash);
    event RuleRemoved(bytes32 ruleHash);
    event TransferValidated(address indexed from, address indexed to, uint256 amount);

    function addRule(bytes32 ruleHash) external;
    function removeRule(bytes32 ruleHash) external;
    function isTransferAllowed(address from, address to, uint256 amount) external view returns (bool);
}
