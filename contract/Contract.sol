pragma solidity ^0.4.17;

interface Regulator {
    function checkValue(uint amount) returns (bool);
    function loan() returns (bool);
}

contract Bank is Regulator {
    uint private value;
    address private owner;

    modifier ownerFunc {
        require(owner == msg.sender);
        _;
    }

    function Bank(uint amount) {
        value = amount;
        owner = msg.sender;
    }

    function deposit(uint amount) ownerFunc {
        value += amount;
    }

    function withdraw(uint amount) ownerFunc {
        if (checkValue(amount)) {
            value -= amount;
        }
    }

    function balance() returns (uint) {
        return value;
    }

    function checkValue(uint amount) returns (bool) {
        return value >= amount;
    }

    function loan() returns (bool) {
        return value > 0;
    }
}

contract Contract is Bank(10) {
    string private name;
    uint private age;

    function setName(string _name) {
        name = _name;
    }

    function getName() returns (string) {
        return name;
    }

    function setAge(uint _age) {
        age = _age;
    }

    function getAge() returns (uint) {
        return age;
    }
}