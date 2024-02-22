// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {King} from "../src/king/King.sol";
import {KingDos} from "../src/king/KingDos.sol";
import {Test, console2} from "forge-std/Test.sol";
import "../src/account.sol";


contract KingTest is Test {
    King public sc;
    KingDos public scHelper;

    function setUp() public {
        sc = new King{value: 100}();
        scHelper = new KingDos{value: 2 ether}(payable(sc));
        assertEq(sc._king(), address(this));
    }

    function test_Hack() public {
        // normal play
        vm.startBroadcast(account.ACC_PRIVATE_KEY_0);
        vm.deal(account.ACC_0, 10 ether);
        bool success;
        bytes memory message;
        (success, message) = address(sc).call{value: 150}("");
        if(!success) {
            assembly {
                message := add(message, 68)
            }
            revert(string(message));
        }
        assertEq(sc._king(), account.ACC_0);
        // hack
        assertEq(scHelper.hack(uint(200)), address(scHelper));
        // can't serve
        (success, message) = address(sc).call{value: 300}("");
        //vm.expectRevert();
        assertEq(success, false);
    }

    receive() payable external {

    }
}
