pragma solidity ^0.8.0;

import {IDetectionBot, DoubleEntryPoint, Forta} from "./DoubleEntryPoint.sol";
import {Test, console2} from "forge-std/Test.sol";


contract DetectionBot is IDetectionBot {

    address public forbiddenAddress;
    Forta public forta;

    constructor(address _forbiddenAddress, address _fortaAddress) {
        forbiddenAddress = _forbiddenAddress;
        forta = Forta(_fortaAddress);
        // register
    }

    function handleTransaction(address user, bytes calldata msgData) external {
        (, , address _from) = _decode(msgData);
        if(_from == forbiddenAddress) {
            forta.raiseAlert(user);
        }
    }

    function _decode(bytes calldata _data) private returns(address _to, uint256 _value, address _from) {
            bytes4 sig = bytes4(_data[:4]);
            console2.logBytes4(sig);
            console2.logBytes4(bytes4(keccak256("delegateTransfer(address,uint256,address)")));
            (_to, _value, _from) = abi.decode(_data[4:], (address, uint256, address));
    }
}