pragma solidity ^0.4.17;

import "browser/Coin.sol";
import "browser/ERC20.sol";
import "browser/ERC223.sol";


contract Token is Coin("TK", "Token", 18, 1000), ERC20, ERC223 {

    function Token() public {
        _balanceOf[msg.sender] = _totalSupply;
    }

    function totalSupply() public constant returns (uint) {
        return _totalSupply;
    }

    function balanceOf(address _addr) public constant returns (uint) {
        return _balanceOf[_addr];
    }

    function transfer(address _to, uint _value) returns (bool) {
        if (_value > 0 &&
            _value <= _balanceOf[msg.sender]) {
            _balanceOf[msg.sender] -= _value;
            _balanceOf[_to] += _value;
            Transfer(msg.sender, _to, _value);
            return true;
        }
        return false;
    }

    function transferFrom(address _from, address _to, uint _value) returns (bool) {
        if (_allowances[_from][msg.sender] > 0 &&
            _value > 0 &&
            _allowances[_from][msg.sender] >= _value &&
            _balanceOf[_from] >= _value) {
                _balanceOf[_from] -= _value;
                _balanceOf[_to] += _value;
                _allowances[_from][msg.sender] == _value;
                Transfer(_from, _to, _value);
                return true;
            }
            return false;
    }

    function approve(address _spender, uint _value) returns (bool success) {
        _allowances[msg.sender][_spender] = _value;
        Approval(msg.sender, _spender, _value);
        return true;
    }

    function allowance(address _owner, address _spender) constant returns (uint remaining) {
        return _allowances[_owner][_spender];
    }
}