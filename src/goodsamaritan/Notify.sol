pragma solidity >=0.8.0 <0.9.0;

import {INotifyable, GoodSamaritan} from "./GoodSamaritan.sol";

contract Notify is INotifyable {

    error NotEnoughBalance();

    function notify(uint256 amount) external {
        if(amount == 10) {
            revert NotEnoughBalance();
        }
    }

    function request(address samaritan) external {
        GoodSamaritan(samaritan).requestDonation();
    }
}