pragma solidity ^0.4.17;

contract MultiSigWallet {
    address private _owner;
    mapping (address => uint8) private _owners;

    modifier isOwner() {
        require(msg.sender == _owner);
        _;
    }

    modifier validOwner() {
        require(msg.sender == _owner || _owners[msg.sender] == 1);
        _;
    }

    function MultiSigWallet() public {
        _owner = msg.sender;
    }

    function addOwner(address newOwner) public isOwner {
        _owners[newOwner] = 1;
    }

    function removeOwner(address existingOwner) public isOwner {
        _owners[existingOwner] = 0;
    }
}