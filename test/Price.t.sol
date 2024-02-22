// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Test, console2} from "forge-std/Test.sol";
import {Shop} from "../src/shop/Shop.sol";
import {ShopHacker} from "../src/shop/ShopHacker.sol";

contract ShopTest is Test {
    Shop public sc;
    ShopHacker public scHacker;

    function setUp() public {
        sc = new Shop();
        scHacker = new ShopHacker(address(sc));
    }

    function test_Hack() public {
        uint256 cost = scHacker.buy();
        assertEq(cost, 1);
    }
}
