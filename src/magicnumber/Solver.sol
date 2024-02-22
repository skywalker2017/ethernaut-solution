pragma solidity ^0.8.0;

interface Solver {
    function whatIsTheMeaningOfLife() external view returns(bytes32);
}

contract solver {
    constructor() {
        assembly {
            mstore(0x00, 0x602a60005260206000f3)
            return(0x16, 0x0a)
        }
    }
}
