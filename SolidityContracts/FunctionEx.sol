pragma solidity ^0.5.13;

contract FunctionExample{

    mapping(address => uint) public balanceReceived;

    function receiveMoney() public payable {
        balanceReceived[msg.sender] += msg.value;
    }

    function withdrawMoneyTo(address payable _to, uint _amount) public {
        assert(balanceReceived[msg.sender] >= _amount);
        balanceReceived[msg.sender] -= _amount;
        _to.transfer(_amount);
    }

    function () external payable {
        receiveMoney();
    }
}