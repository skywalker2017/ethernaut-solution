pragma solidity ^0.8.0;

import {CoinFlip} from "./CoinFlip.sol";

contract CoinFlipHacker {

    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

    function tryFlip() public view returns(bool isFlip) {
        //bool isFlip = false;
        return flip(true);
    }

    function flip(bool _guess) private view returns (bool) {
    uint256 blockValue = uint256(blockhash(block.number - 1));
    uint256 coinFlip = blockValue / FACTOR;
    bool side = coinFlip == 1 ? true : false;

    if (side == _guess) {
      return true;
    } else {
      return false;
    }
  }
}