// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {Script} from "forge-std/Script.sol";
import {ABToken} from "../src/ABToken.sol";

contract DeployABToken is Script {
    address public deployer;

    function run() external {
        deployer = vm.envAddress("DEPLOYER_KEY");

        vm.startBroadcast(deployer);

        new ABToken("ABToken", "ABT", deployer);

        vm.stopBroadcast();
    }
}
