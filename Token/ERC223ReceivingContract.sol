pragma solidity ^0.4.17;

contract ERC223ReceivingContract {
    function ERC223ReceivingContract(address _mock) public {}
    function tokenFallback(address _from, uint _value, bytes _data) public;
}