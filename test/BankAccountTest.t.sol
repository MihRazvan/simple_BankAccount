// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from "lib/forge-std/src/Test.sol";
import {BankAccount} from "../src/BankAccount.sol";
import {DeployBankAccount} from "../script/DeployBankAccount.s.sol";

contract BankAccountTest is Test {
    BankAccount bankAccount;
    address user = vm.addr(1);

    event Deposit(address indexed depositor, uint256 amount);
    event WithdrawInitiated(address indexed withdrawer, uint256 amount);
    event WithdrawCompleted(address indexed withdrawer, uint256 amount);

    // chatGPT spune ca e un mod dubios de a initializa contractul cand poti face bankAccount = new BankAccount();
    function setUp() external {
        DeployBankAccount deployBankAccount = new DeployBankAccount();
        bankAccount = deployBankAccount.run();
        vm.deal(user, 10 ether);
    }

    function testDeposit() public {
        vm.prank(user);
        bankAccount.deposit{value: 1 ether}();
        assertEq(bankAccount.addressToValue(user), 1 ether);
    }

    function testWithdraw() public {
        vm.prank(user);
        bankAccount.deposit{value: 1 ether}();

        uint256 initialBalance = user.balance;
        vm.prank(user);
        bankAccount.withdraw();

        uint256 finalBalance = user.balance;
        assertEq(initialBalance + 1 ether, finalBalance);
        assertEq(bankAccount.addressToValue(user), 0);
    }

    function testMultipleDeposits() public {
        vm.prank(user);
        bankAccount.deposit{value: 1 ether}();
        vm.prank(user);
        bankAccount.deposit{value: 2 ether}();
        assertEq(bankAccount.addressToValue(user), 3 ether);
    }

    function testZeroValueDeposit() public {
        vm.expectRevert("Deposit value must be greater than 0");
        vm.prank(user);
        bankAccount.deposit{value: 0}();
    }

    function testContractBalanceAfterWithdrawal() public {
        vm.prank(user);
        bankAccount.deposit{value: 1 ether}();
        uint256 initialContractBalance = address(bankAccount).balance;

        vm.prank(user);
        bankAccount.withdraw();

        assertEq(address(bankAccount).balance, initialContractBalance - 1 ether); // Assumes full withdrawal
    }

    function testDepositEvent() public {
        vm.expectEmit(true, false, false, true);
        emit Deposit(user, 1 ether);
        vm.prank(user);
        bankAccount.deposit{value: 1 ether}();
    }

    function testWithdrawEvent() public {
        vm.prank(user);
        bankAccount.deposit{value: 1 ether}();

        vm.expectEmit(true, false, false, true);
        emit WithdrawInitiated(user, 1 ether);

        vm.prank(user);
        bankAccount.withdraw();
    }
}
