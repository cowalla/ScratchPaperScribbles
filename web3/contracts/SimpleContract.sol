pragma solidity ^0.4.0;

contract SimpleContract {

    address public owner;

    event SimpleEvent();

    constructor() public {
        owner = msg.sender;
        emit SimpleEvent();
    }
}
