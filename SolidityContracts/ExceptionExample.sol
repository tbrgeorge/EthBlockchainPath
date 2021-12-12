pragma solidity ^0.6.0;

contract ExceptionExample{

    mapping(address => uint) public balanceReceived;

    function reveiveMoney() public payable {
        balanceReceived[msg.sender] += msg.value;
    }

    function withdrawMoneyTo(address payable _to, uint _amount) public {
        assert(balanceReceived[msg.sender] >= _amount);
        balanceReceived[msg.sender] -= _amount;
        _to.transfer(_amount);
    }
}