// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GatekeeperOne} from "./GateKeeperOne.sol";
import {GatekeeperOneMock} from "./GateKeeperOneMock.sol";
import {Test, console2} from "forge-std/Test.sol";


contract GatekeeperOneHelper {
    GatekeeperOne public entrant;
    GatekeeperOneMock public entrantMock;

    constructor(address _entrant, address _entrantMock) {
        entrant = GatekeeperOne(_entrant);
        entrantMock = GatekeeperOneMock(_entrantMock);
    }

    function kick(bytes8 _key) public returns (bool) {
        return entrant.enter(_key);
    }

    function kickMock(bytes8 _key) public returns (bool) {
        return entrantMock.enter(_key);
    }
}
