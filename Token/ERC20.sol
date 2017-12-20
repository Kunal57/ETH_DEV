pragma solidity ^0.4.17;

interface ERC20 {
    function transferFrom(address _from, address _to, uint _value) returns (bool success);
    function approve(address _spender, uint _value) returns (bool success);
    function allowance(address _owner, address _spender) constant returns (uint remaining);
    event Approval(address indexed _owner, address indexed _spender, uint _value);
}