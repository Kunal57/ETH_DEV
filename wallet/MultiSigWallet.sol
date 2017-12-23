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

    event DepositFunds(address from, uint amount);

    function MultiSigWallet() public {
        _owner = msg.sender;
    }

    function addOwner(address newOwner) public isOwner {
        _owners[newOwner] = 1;
    }

    function removeOwner(address existingOwner) public isOwner {
        _owners[existingOwner] = 0;
    }

    function () public payable {
        DepositFunds(msg.sender, msg.value);
    }

    function withdraw(uint amount) public validOwner {
        require(address(this).balance >= amount);
        msg.sender.transfer(amount);
    }
}