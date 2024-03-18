// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "lib/forge-std/src/Script.sol";
import {BankAccount} from "src/BankAccount.sol";

contract DeployBankAccount is Script {
    function run() external {
        vm.startBroadcast();
        BankAccount bankAccount = new BankAccount();
        vm.stopBroadcast();
    }
}
