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

  function Crowdsale(address token, uint start, uint end, uint price, uint limit) {
    _token = Token(token);
    _start = start;
    _end = end;
    _price = price;
    _limit = limit;
  }

  function availableBalance() public view returns(uint) {
    return _balance;
  }

  function buy() public payable {
    buyFor(msg.sender);
  }

  function buyFor(address beneficiary) public payable {
    _token.transfer(beneficiary, 1);
    _balance = _balance.sub(1);
  }

  function tokenFallback(address _from, uint _value, bytes _data) public {
    _balance = _balance.add(_value);
  }

}