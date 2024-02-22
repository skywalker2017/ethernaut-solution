pragma solidity ^0.6.12;
pragma experimental ABIEncoderV2;

import {Reentrance} from "../src/reentrance/Reentrance.sol";
import {ReentranceHacker} from "../src/reentrance/ReentranceHacker.sol";

import {Test, console2} from "forge-std/Test.sol";

contract ReentranceTest is Test {
    Reentrance sc;
    ReentranceHacker hacker;
    function setUp() public {
        sc = new Reentrance();
        sc.donate{value: 100 ether}(address(this));
        hacker = new ReentranceHacker(payable(address(sc)));
        assertEq(address(sc).balance, 100 ether);
    }

    function test_Hack() public {
        // get orginal balance
        uint256 _balance = address(sc).balance;
        hacker.hack{value: _balance}();
        assertEq(address(sc).balance, 0);
        assertEq(address(hacker).balance, 200 ether);
    }

    receive() payable external {}
}
