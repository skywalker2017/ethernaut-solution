pragma solidity ^0.8.0;

contract ForceHelper {

    function destruct(address payable _benfit) public {
        selfdestruct(_benfit);
    }

    receive() external payable {
        revert("hahaha");
    }
}