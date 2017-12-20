pragma solidity ^0.4.17;

contract Bank {
    uint private value;

    function Bank(uint amount) {
        value = amount;
    }

    function deposit(uint amount) {
        value += amount;
    }

    function withdraw(uint amount) {
        value -= amount;
    }

    function balance() returns (uint) {
        return value;
    }

    function loan() returns (bool);
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

    function loan() returns (bool) {
        return true;
    }
}