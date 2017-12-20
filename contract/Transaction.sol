pragma solidity ^0.4.17;

contract Transaction {

    event SenderLogger(address);
    event ValueLogger(uint);

    function () payable {
        SenderLogger(msg.sender);
        ValueLogger(msg.value);
    }

}