// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ICompliance} from "./interfaces/ICompliance.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";


/** @dev pt-br: esse contrato é usado para adicionar regras de compliance e verificar se o usuário é compliant */
contract Compliance is ICompliance, Ownable {
    mapping(bytes32 => bool) private complianceRules;

    modifier onlyValidRule(bytes32 ruleHash) {
        require(ruleHash != bytes32(0), "Invalid rule");
        _;
    }

    function addRule(bytes32 ruleHash) external onlyOwner onlyValidRule(ruleHash) {
        complianceRules[ruleHash] = true;
        emit RuleAdded(ruleHash);
    }

    function removeRule(bytes32 ruleHash) external onlyOwner onlyValidRule(ruleHash) {
        complianceRules[ruleHash] = false;
        emit RuleRemoved(ruleHash);
    }

    function isTransferAllowed(address from, address to, uint256 amount) external view override returns (bool) {
        // Implement logic to check against compliance rules
        // Placeholder for actual rule validation
        return complianceRules[keccak256(abi.encodePacked(from, to, amount))];
    }
}
