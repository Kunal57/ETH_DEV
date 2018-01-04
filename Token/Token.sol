pragma solidity ^0.4.17;

import "browser/Coin.sol";
import "browser/ERC20.sol";
import "browser/ERC223.sol";
import "browser/ERC223ReceivingContract.sol";
import "https://github.com/OpenZeppelin/zeppelin-solidity/blob/master/contracts/math/SafeMath.sol"


contract Token is Coin("TK", "Token", 18, 1000), ERC20, ERC223 {

    using SafeMath for uint;

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
            _value <= _balanceOf[msg.sender] &&
            !isContract(_to)) {
            _balanceOf[msg.sender].sub(_value);
            _balanceOf[_to].add(_value);
            Transfer(msg.sender, _to, _value);
            return true;
        }
        return false;
    }

    function transfer(address _to, uint _value, bytes _data) public returns (bool) {
        if (_value > 0 &&
            _value <= _balanceOf[msg.sender] &&
            isContract(_to)) {
            _balanceOf[msg.sender].sub(_value);
            _balanceOf[_to].add(_value);
            ERC223ReceivingContract _contract = ERC223ReceivingContract(_to);
            _contract.tokenFallback(msg.sender, _value, _data);
            Transfer(msg.sender, _to, _value, _data);
            return true;
        }
        return false;
    }

    function isContract(address _addr) returns (bool) {
        uint codeSize;
        assembly {
            codeSize := extcodesize(_addr)
        }
        return codeSize > 0;
    }

    function transferFrom(address _from, address _to, uint _value) returns (bool) {
        if (_allowances[_from][msg.sender] > 0 &&
            _value > 0 &&
            _allowances[_from][msg.sender] >= _value &&
            _balanceOf[_from] >= _value) {
                _balanceOf[_from].sub(_value);
                _balanceOf[_to].add(_value);
                _allowances[_from][msg.sender] == _value;
                Transfer(_from, _to, _value);
                return true;
            }
            return false;
    }

    function approve(address _spender, uint _value) returns (bool) {
        _allowances[msg.sender][_spender] = _value;
        Approval(msg.sender, _spender, _value);
        return true;
    }

    function allowance(address _owner, address _spender) constant returns (uint) {
        return _allowances[_owner][_spender];
    }
}