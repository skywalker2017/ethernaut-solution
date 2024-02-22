// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {GatekeeperThree} from "../src/gatekeeperthree/GatekeeperThree.sol";
import {Kick} from "../src/gatekeeperthree/Kicker.sol";
import {Test, console2} from "forge-std/Test.sol";

contract GatekeeperThreeTest is Test {
    GatekeeperThree public sc;
    Kick public kicker;

    function setUp() public {
        sc = new GatekeeperThree();
        sc.createTrick();
        kicker = new Kick{value: 0.01 ether}(payable(address(sc)));
    }

    function test_Hack() public {
        kicker.kick();
        assertEq(sc.entrant(), tx.origin);
    }
}
