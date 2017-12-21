pragma solidity ^0.4.17;

contract Casino {

    uint private start;

    uint private buyPeriod = 1000;
    uint private verifyPeriod = 100;
    uint private claimPeriod = 100;

    mapping (address => uint) _tickets;
    address[] _entries;
    address[] _verified;

    function Casino()
        public {
            start = block.timestamp;
    }

    // This function should NOT be a part of the contract
    function generateHash(uint number, uint salt)
        public
        payable
        returns (bool) {
        return buyTicket(uint(keccak256(number + salt)));
    }

    function buyTicket(uint hash)
        public
        payable
        returns (bool) {
        // Within the timeframe
        require(block.timestamp < start + buyPeriod);
        // Correct amount
        require(1 ether == msg.value);
        // 1 entry per address
        require(_tickets[msg.sender] == 0);
        _tickets[msg.sender] = hash;
        _entries.push(msg.sender);
    }

}