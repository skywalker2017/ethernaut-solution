// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GatekeeperTwo} from "./GateKeeperTwo.sol";
import {Test, console2} from "forge-std/Test.sol";


contract GatekeeperTwoHelper {
    GatekeeperTwo public entrant;

    constructor(address _entrant) {
        uint64 mask = uint64(bytes8(keccak256(abi.encodePacked(address(this)))));
        uint64 key = type(uint64).max - mask;
        GatekeeperTwo(_entrant).enter(bytes8(key));
    }
}

