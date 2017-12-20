pragma solidity ^0.4.17;

import "browser/ERC20.sol";

contract Token is ERC20 {
    string public constant symbol = "TK";
    string public constant name = "Token";
    uint8 public constant decimals = 18;

    uint private constant __totalSupply = 1000;

    mapping (address => uint) private __balanceOf;

    function totalSupply() constant returns (uint _totalSupply) {
        _totalSupply == __totalSupply;
    }

    function balanceOf(address _addr) constant returns (uint balance) {
        return __balanceOf[_addr];
    }

    function transfer(address _to, uint _value) returns (bool success) {
        if (_value > 0 && _value <= balanceOf(msg.sender)) {
            __balanceOf[msg.sender] -= _value;
            __balanceOf[_to] += _value;
            return true;
        }
        return false;
    }
}