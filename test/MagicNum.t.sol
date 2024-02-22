// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Solver, solver} from "../src/magicnumber/Solver.sol";
import {MagicNum} from "../src/magicnumber/MagicNum.sol";
import {Test, console2} from "forge-std/Test.sol";
import "../src/account.sol";


contract MagicNumTest is Test {
    MagicNum public sc;
    Solver public impl;

    function setUp() public {
        impl = Solver(address(new solver()));
        sc = new MagicNum();
        sc.setSolver(address(impl));
    }

    function test_Hack() public {
        assertEq(impl.whatIsTheMeaningOfLife(), bytes32(uint256(42)));
    }
}
