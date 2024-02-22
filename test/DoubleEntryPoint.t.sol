// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {DelegateERC20, IDetectionBot, IForta, Forta, CryptoVault, LegacyToken, DoubleEntryPoint} from "../src/doubleentrypoint/DoubleEntryPoint.sol";
import {DetectionBot} from "../src/doubleentrypoint/DetectionBot.sol";
import {Test, console2} from "forge-std/Test.sol";
import {IERC20} from "openzeppelin-contracts-08/token/ERC20/ERC20.sol";

contract DoubleEntryPointTest is Test {
    CryptoVault public sc;
    LegacyToken public ltoken;
    DoubleEntryPoint public dtoken;
    Forta public forta;
    DetectionBot public bot;

    function setUp() public {
        sc = new CryptoVault(address(this));
        ltoken = new LegacyToken();
        ltoken.mint(address(sc), 100);
        forta = new Forta();
        dtoken = new DoubleEntryPoint(
            address(ltoken),
            address(sc),
            address(forta),
            address(this)
        );
        sc.setUnderlying(address(dtoken));
        assertEq(ltoken.balanceOf(address(sc)), 100);
        assertEq(dtoken.balanceOf(address(sc)), 100);
    }

    /* function test_Normal() public {
        sc.sweepToken(IERC20(ltoken));
        assertEq(ltoken.balanceOf(address(sc)), 0);
        assertEq(ltoken.balanceOf(address(this)), 100);
        // revert on the next call
        vm.expectRevert(bytes("Can't transfer underlying token"));
        sc.sweepToken(IERC20(dtoken));
    }

    function test_Hack() public {
        // hack
        ltoken.delegateToNewContract(DelegateERC20(dtoken));
        sc.sweepToken(IERC20(ltoken));
        assertEq(dtoken.balanceOf(address(sc)), 0);
        assertEq(dtoken.balanceOf(address(this)), 100);
    } */

    function test_Protect() public {
        bot = new DetectionBot(address(sc), address(forta));
        forta.setDetectionBot(address(bot));
        ltoken.delegateToNewContract(DelegateERC20(dtoken));
        vm.expectRevert(bytes("Alert has been triggered, reverting"));
        sc.sweepToken(IERC20(ltoken));
        assertEq(dtoken.balanceOf(address(sc)), 100);
    }
}
