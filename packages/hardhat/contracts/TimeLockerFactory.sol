// SPDX-License-Identifier: MIT

pragma solidity ^0.6.12;

import "./TimeLocker.sol";

contract TimeLockerFactory { 
    mapping(address => address[]) lockers;
    TimeLocker[] public deployedLockers;

    function getWallets(address user) 
        public
        view
        returns(address[] memory)
    {
        return lockers[user];
    }
    function deployTimeLocker(uint256 unlockAt)
        public
        returns(address lockerAddress)
    {
        TimeLocker locker = new TimeLocker(unlockAt);
        lockerAddress = address(locker);
        lockers[msg.sender].push(lockerAddress);
        LockerCreated(lockerAddress, msg.sender, now, unlockAt);
    }
    fallback() external payable {
        revert();
    }
    receive() external payable {
        revert();
    }
    event LockerCreated(address locker, address from, uint256 createdAt, uint256 unlockAt);
}