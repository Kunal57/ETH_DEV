pragma solidity ^0.4.17;

contract MultiSigWallet {
    address private _owner;
    mapping (address => uint8) private owners;

    modifier isOwner() {
        require(msg.sender == _owner);
        _;
    }

    function MultiSigWallet() public {
        _owner = msg.sender;
    }
}