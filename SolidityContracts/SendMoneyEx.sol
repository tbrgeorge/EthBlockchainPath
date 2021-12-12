pragma solidity ^0.5.13;

contract SendMoneyEx {
    uint public balanceReceived;
    address owner;
    bool public paused;

    constructor() public {
        owner = msg.sender;
    }
    function reveiveMoney() public payable {
        balanceReceived += msg.value;
    }

    function getBalance() public view returns(uint) {
        return address(this).balance;
    }

    function withdrawMoney() public {
        address payable to = msg.sender; //sender is the address from which address the smart contrcat is called
        to.transfer(this.getBalance());
    }

    function withdrawMoneyTo(address payable _to) public {
        require(msg.sender == owner, "you are not the owner!");
        require(!paused, "contract paused!");
        _to.transfer(this.getBalance());
    }

    function setpaused(bool _paused) public {
        require(msg.sender == owner, "you are not the owner!");
        paused = _paused;
    }

    function destruct(address payable _to) public {
        require(msg.sender == owner, "you are not the owner!");
        selfdestruct(_to);
    }
}