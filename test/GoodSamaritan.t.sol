// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.0 <0.9.0;

import {GoodSamaritan, Coin} from "../src/goodsamaritan/GoodSamaritan.sol";
import {Notify} from "../src/goodsamaritan/Notify.sol";
import {Test, console2} from "forge-std/Test.sol";


contract GoodSamaritanTest is Test {
    GoodSamaritan public sc;
    Notify public hacker;

    function setUp() public {
        sc = new GoodSamaritan();
        hacker = new Notify();
    }

    function test_Hack() public {
        assertNotEq(Coin(sc.coin()).balances(address(sc.wallet())), 0);
        hacker.request(address(sc));
        assertEq(Coin(sc.coin()).balances(address(sc.wallet())), 0);
    }
}
