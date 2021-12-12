pragma solidity ^0.6.0;

contract SimpleMappingEx{
    mapping(uint => bool) public myMapping;
    mapping(address => bool) public myAddress;

    function setValue(uint _index) public {
        myMapping[_index] = true;
    }

    function setAddressTrue() public {
        myAddress[msg.sender] = true;
    }
} 