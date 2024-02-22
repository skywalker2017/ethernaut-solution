pragma solidity ^0.8.0;

contract BadLibrary {  

  function setTime(uint _time) public {
    assembly {
        sstore(0x02, _time)
    }
  }
}