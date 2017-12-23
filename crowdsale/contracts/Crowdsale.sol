pragma solidity ^0.4.17;

import "./ERC223ReceivingContract.sol";
import "./Token.sol";
import "./SafeMath.sol";

contract Crowdsale is ERC223ReceivingContract {

  using SafeMath for uint;

  Token private _token;
  uint private _start;
  uint private _end;
  uint private _price;
  uint private _limit;
  uint private _balance;

  mapping (address => uint) private _limits;

  modifier isAvailable() {
    require(block.number >= _start && block.number < _end);
    require(_balance > 0);
    _;
  }

  modifier withinLimit(address recipient, uint value) {
    uint amount = value.div(_price);
    require(_limits[recipient].add(amount) <= _limit);
    _;
  }

  event Buy(address beneficiary, uint amount);

  function Crowdsale(address token, uint start, uint end, uint price, uint limit) public {
    _token = Token(token);
    _start = start;
    _end = end;
    _price = price;
    _limit = limit;
  }

  function availableBalance() public view returns(uint) {
    return _balance;
  }

  function () public payable {
    revert();
  }

  function buy() public payable {
    buyFor(msg.sender);
  }

  function buyFor(address beneficiary) public isAvailable withinLimit(beneficiary, msg.value) payable {
    uint amount = msg.value.div(_price);
    _token.transfer(beneficiary, amount);
    _limits[beneficiary] = _limits[beneficiary].add(amount);
    _balance = _balance.sub(amount);
    Buy(beneficiary, amount);
  }

  function tokenFallback(address _from, uint _value, bytes _data) public {
    _balance = _balance.add(_value);
  }

}