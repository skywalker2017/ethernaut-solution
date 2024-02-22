// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Test, console2} from "forge-std/Test.sol";
import {CoinFlip} from "../src/coinflip/CoinFlip.sol";
import {CoinFlipHacker} from "../src/coinflip/CoinFlipHacker.sol";


contract CoinFlipTest is Test {
    CoinFlip public sc;
    CoinFlipHacker hacker;


    function setUp() public {
        sc = new CoinFlip();
        hacker = new CoinFlipHacker();
    }

    function test_Hack() public {
        for (uint256 i = 1000; i < 1100; ++i) {
            vm.roll(i);
            bool win;
            bool result = hacker.tryFlip();
            if (result) {
                win = sc.flip(true);
            } else {
                console2.log(false);
                win = sc.flip(false);
            }
        }
        uint256 wins = sc.consecutiveWins();
        assertGt(wins, 10);

    }
}
