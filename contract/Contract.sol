pragma solidity ^0.4.17;

contract Bank {
    uint private value;

    function deposit(uint amount) {
        value += amount;
    }

    function withdraw(uint amount) {
        value -= amount;
    }

    function balance() returns (uint) {
        return value;
    }
}

contract Contract is Bank {
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