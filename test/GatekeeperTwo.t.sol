// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {GatekeeperTwo} from "../src/gatekeepertwo/GatekeeperTwo.sol";
import {GatekeeperTwoHelper} from "../src/gatekeepertwo/GatekeeperTwoHelper.sol";
import {Test, console2} from "forge-std/Test.sol";
import "../src/account.sol";

contract GatekeeperTwoTest is Test {
    GatekeeperTwo public sc;

    function setUp() public {
        sc = new GatekeeperTwo();
    }

    function test_Hack() public {
        vm.startBroadcast(account.ACC_PRIVATE_KEY_0);

        address acc = account.ACC_0;
        new GatekeeperTwoHelper(address(sc));
        assertEq(sc.entrant(), acc);
    }
}
