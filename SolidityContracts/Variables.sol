pragma solidity ^0.5.13;

contract WorkingWithVars{
    uint256 public myUint;
    bool public myBool;
    uint8 public myUint8;
    address public myAddress;
    string public myString = 'salut';

    function setMyUint(uint _myUint) public {
        myUint = _myUint;
    }

    function setMyBool(bool _myBool) public {
        myBool = _myBool;
    }
    

    function incrementUint() public {
       myUint8++;
    }

    function decrementUint() public {
       myUint8--;
    }

    function setMyAddress(address _myAddress) public {
        myAddress = _myAddress;
    }

    function getBalanceAddress() public view returns(uint) {
        return myAddress.balance;
    }

    function setMyString(string memory _myString) public {
        myString = _myString;
    }

}

