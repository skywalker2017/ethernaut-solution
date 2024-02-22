// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Elevator} from "../src/elevator/Elevator.sol";
import {ElevatorHacker} from "../src/elevator/ElevatorHacker.sol";

import {Test, console2} from "forge-std/Test.sol";


contract ElevatorTest is Test {
    Elevator public sc;
    ElevatorHacker public scHacker;

    function setUp() public {
        sc = new Elevator();
        scHacker = new ElevatorHacker(address(sc));
    }

    function test_Hack() public {
        scHacker.hack();
        assertEq(sc.top(), true);
        assertEq(sc.floor(), 1);
    }
}
