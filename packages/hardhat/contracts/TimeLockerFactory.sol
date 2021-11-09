// SPDX-License-Identifier: MIT

pragma solidity ^0.6.12;

import "./TimeLocker.sol";

contract TimeLockerFactory { 
    mapping(address => address[]) wallets;

    function getWallets(address user) 
        public
        view
        returns(address[])
    {
        return wallets[user];
    }
    function deployTimeLocker(address owner, uint256 unlockAt)
        payable
        public
        returns(address wallet)
    {
        wallet = new TimeLocker(msg.sender, owner, unlockAt);
        wallets[msg.sender].push(wallet);
        if (msg.sender != owner){
            wallets[owner].push(wallet);
        }
        wallet.transfer(msg.value);
        LockerCreated(wallet, msg.sender, owner, now, unlockAt);
    }
    function () public {
        revert();
    }
    event LockerCreated(address wallet, address from, address to, uint256 createdAt, uint256 unlockAt);
}