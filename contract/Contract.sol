pragma solidity ^0.4.17;

contract Contract {
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