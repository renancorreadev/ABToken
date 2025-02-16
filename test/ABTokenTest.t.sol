// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {console} from "forge-std/console.sol";
import {Test} from "forge-std/Test.sol";
import {ABToken} from "../src/ABToken.sol";

import {MockIdentityRegistry} from "./mocks/IdentityRegistryMock.sol";
import {MockModularCompliance} from "./mocks/ModularComplianceMock.sol";
import {MockIdentityOnChainID} from "./mocks/IdentityOnChainIDMock.sol";

contract ERC3643Test is Test {
    address public owner;
    uint256 private ownerPrivateKey;

    /// @dev Smart contract instances
    ABToken token;

    // Mocks setups
    MockIdentityRegistry identityRegistry;
    MockModularCompliance compliance;
    MockIdentityOnChainID onchainID;

    // ------------------------------------------------------------
    function setUp() public {
        // 🔹 Cria o owner
        (owner, ownerPrivateKey) = makeAddrAndKey("owner");

        vm.startPrank(owner);

        identityRegistry = new MockIdentityRegistry();
        compliance = new MockModularCompliance();
        onchainID = new MockIdentityOnChainID();

        // 🔹 Faz deploy do contrato
        token = new ABToken();

        // 🔹 Chama `initialize()`
        token.init(
            address(identityRegistry),
            address(compliance),
            "TestABToken",
            "TTK",
            18,
            address(onchainID)
        );

        vm.stopPrank();
    }

    function testDeployment() public view {
        string memory tokenName = token.name();
        console.log("Token Name:", tokenName);
        assertEq(tokenName, "TestABToken", "Nome do token incorreto");
    }
}
