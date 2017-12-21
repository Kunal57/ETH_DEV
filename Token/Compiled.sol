pragma solidity ^0.4.17;

interface ERC20 {
    function transferFrom(address _from, address _to, uint _value) public returns (bool success);
    function approve(address _spender, uint _value) public returns (bool success);
    function allowance(address _owner, address _spender) public constant returns (uint remaining);
    event Approval(address indexed _owner, address indexed _spender, uint _value);
}

interface ERC223 {
    function transfer(address _to, uint _value, bytes _data) public returns (bool);
    event Transfer(address indexed from, address indexed to, uint value, bytes indexed data);

}

library SafeMath {
  function mul(uint256 a, uint256 b) internal pure returns (uint256) {
    if (a == 0) {
      return 0;
    }
    uint256 c = a * b;
    assert(c / a == b);
    return c;
  }

  function div(uint256 a, uint256 b) internal pure returns (uint256) {
    // assert(b > 0); // Solidity automatically throws when dividing by 0
    uint256 c = a / b;
    // assert(a == b * c + a % b); // There is no case in which this doesn't hold
    return c;
  }

  function sub(uint256 a, uint256 b) internal pure returns (uint256) {
    assert(b <= a);
    return a - b;
  }

  function add(uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a + b;
    assert(c >= a);
    return c;
  }
}

contract ERC223ReceivingContract {
    function tokenFallback(address _from, uint _value, bytes _data) public;
}

contract Coin {
    string internal _symbol;
    string internal _name;
    uint8 internal _decimals;
    uint internal _totalSupply = 1000;
    mapping (address => uint) internal _balanceOf;
    mapping (address => mapping (address => uint)) internal _allowances;

    function Coin(string symbol, string name, uint8 decimals, uint totalSupply) public {
        _symbol = symbol;
        _name = name;
        _decimals = decimals;
        _totalSupply = totalSupply;
    }

    function name() public constant returns (string) {
        return _name;
    }

    function symbol() public constant returns (string) {
        return _symbol;
    }

    function decimals() public constant returns (uint) {
        return _decimals;
    }

    function totalSupply() public constant returns (uint) {
        return _totalSupply;
    }

    function balanceOf(address _addr) public constant returns (uint);
    function transfer(address _to, uint _value) public returns (bool);
    event Transfer(address indexed _from, address indexed _to, uint _value);
}

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

    function transfer(address _to, uint _value) public returns (bool) {
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

    function isContract(address _addr) public view returns (bool) {
        uint codeSize;
        assembly {
            codeSize := extcodesize(_addr)
        }
        return codeSize > 0;
    }

    function transferFrom(address _from, address _to, uint _value) public returns (bool) {
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

    function approve(address _spender, uint _value) public returns (bool) {
        _allowances[msg.sender][_spender] = _value;
        Approval(msg.sender, _spender, _value);
        return true;
    }

    function allowance(address _owner, address _spender) public constant returns (uint) {
        return _allowances[_owner][_spender];
    }
}