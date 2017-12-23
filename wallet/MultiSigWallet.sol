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
    event WithdrawFunds(address to, uint amount);
    event TransferFunds(address from, address to, uint amount);

    function MultiSigWallet() public {
        _owner = msg.sender;
    }

    function addOwner(address owner) public isOwner {
        _owners[owner] = 1;
    }

    function removeOwner(address owner) public isOwner {
        _owners[owner] = 0;
    }

    function () public payable {
        DepositFunds(msg.sender, msg.value);
    }

    function withdraw(uint amount) public validOwner {
        require(address(this).balance >= amount);
        msg.sender.transfer(amount);
        WithdrawFunds(msg.sender, amount);
    }

    function transferTo(address to, uint amount) public validOwner {
        require(address(this).balance >= amount);
        msg.sender.transfer(amount);
        TransferFunds(msg.sender, to, amount);
    }
}