pragma solidity ^0.4.17;

import "./ERC223ReceivingContract.sol";

contract Crowdsale is ERC223ReceivingContract {

  address private _token;
  uint private _start;
  uint private _end;
  uint private _price;
  uint private _limit;

  function Crowdsale(address token, uint start, uint end, uint price, uint limit) {
    _token = token;
    _start = start;
    _end = end;
    _price = price;
    _limit = limit;
  }

  function availableBalance() public view returns(uint) {

  }

  function buy() public payable {

  }

  function buyFor(address beneficiary) public payable {

  }

  function tokenFallback(address _from, uint _value, bytes _data) public {

  }

}