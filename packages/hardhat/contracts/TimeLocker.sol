// SPDX-License-Identifier: MIT

pragma solidity ^0.6.12;

import "./Ownable.sol";
import "./IERC20.sol";

contract TimeLocker is Ownable {
    address public creator;
    uint256 public unlockAt;
    uint256 public createdAt;
    
    constructor (
        uint256 _unlockAt
    ) public {
        unlockAt = _unlockAt;
        createdAt = now;
    }
    fallback() external payable {
       Received(msg.sender, msg.value);
    }
    receive() external payable {
        Received(msg.sender, msg.value);
    }

    function withdraw() onlyOwner public {
       require(now >= unlockAt);
       msg.sender.transfer(address(this).balance);
       Withdraw(msg.sender, address(this).balance);
    }
    function withdrawToken(address tokenAddress) onlyOwner public {
       require(now >= unlockAt);
       IERC20 token = IERC20(tokenAddress);
       uint256 tokenBalance = token.balanceOf(address(this));
       token.transfer(this.owner(), tokenBalance);
       WithdrawTokens(tokenAddress, msg.sender, tokenBalance);
    }
    function details() public view returns(uint256, uint256) {
        return (unlockAt, createdAt);
    }
    event Received(address from, uint256 amount);
    event Withdraw(address to, uint256 amount);
    event WithdrawTokens(address tokenContract, address to, uint256 amount);
}
