pragma solidity ^0.4.17;

interface Regulator {
    function checkValue(uint amount) returns (bool);
    function loan() returns (bool);
}

contract Bank is Regulator {
    uint private value;

    function Bank(uint amount) {
        value = amount;
    }

    function deposit(uint amount) {
        value += amount;
    }

    function withdraw(uint amount) {
        if (checkValue(amount)) {
            value -= amount;
        }
    }

    function balance() returns (uint) {
        return value;
    }

    function checkValue(uint amount) returns (bool) {
        return amount <= value;
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