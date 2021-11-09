// SPDX-License-Identifier: MIT

pragma solidity ^0.6.12;

import "./Ownable.sol";
import "./IERC20.sol";

contract TimeLocker is Ownable {
    address public creator;
    address public owner;
    uint256 public unlockAt;
    uint256 public createdAt;
    
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
    constructor (
        address _creator,
        address _owner,
        uint256 _unlockAt
    ) public {
        creator = _creator;
        owner = _owner;
        unlockAt = _unlockAt;
        createdAt = now;
    }
    function() payable public { 
        Received(msg.sender, msg.value);
    }
    function withdraw() onlyOwner public {
       require(now >= unlockAt);
       msg.sender.transfer(this.balance);
       Withdraw(msg.sender, this.balance);
    }
    function withdrawTokens(address _tokenContract) onlyOwner public {
       require(now >= unlockAt);
       ERC20 token = ERC20(_tokenContract);
       uint256 tokenBalance = token.balanceOf(this);
       token.transfer(owner, tokenBalance);
       WithdrawTokens(_tokenContract, msg.sender, tokenBalance);
    }
    function details() public view returns(address, address, uint256, uint256) {
        return (creator, owner, unlockAt, createdAt);
    }
    event Received(address from, uint256 amount);
    event Withdraw(address to, uint256 amount);
    event WithdrawTokens(address tokenContract, address to, uint256 amount);
}