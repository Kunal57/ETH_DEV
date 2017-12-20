pragma solidity ^0.4.17;

import "browser/ERC20.sol";

contract Token is ERC20 {
    string public constant symbol = "TK";
    string public constant name = "Token";
    uint8 public constant decimals = 18;
}