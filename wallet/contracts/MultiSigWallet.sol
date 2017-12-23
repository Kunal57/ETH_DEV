pragma solidity ^0.4.17;

contract MultiSigWallet {

    address private _owner;
    mapping (address => uint8) private _owners;

    uint constant MIN_SIGNATURES = 2;
    uint private _transactionIdx;

    struct Transaction {
        address from;
        address to;
        uint amount;
        uint8 signatureCount;
        mapping (address => uint8) signatures;
    }

    mapping (uint => Transaction) private _transactions;
    uint[] private _pendingTransactions;

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

        WithdrawFunds(msg.sender, amount);
    }

    function transferTo(address to, uint amount) public validOwner {
        require(address(this).balance >= amount);

        TransferFunds(msg.sender, to, amount);
    }
}