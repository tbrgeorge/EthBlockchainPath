//SPDX-License-Identifier: MIT
pragma solidity 0.8.0;
import "./Allowance.sol";

/**
 * @title Wallet
 * @dev receive and withdraws money
 */
contract Wallet is Allowance{
    
    event CurrencySent(address indexed _beneficiary, uint _amount);
    event CurrencyReceived(address indexed _from, uint _amount);

    receive() external payable {
        emit CurrencyReceived(msg.sender, msg.value);
    }

    function withdrawMoney(address payable _toAddress, uint _amount) public ownerOrAllowed(_amount) {
        require(_amount <= address(this).balance, "Wallet doesn't own enough money");
        if(!isOwner()) {
            //msg.sender is the address of the non-owner user which sends money _toAddress
            reduceAllowance(msg.sender, _amount);
        }
        emit CurrencySent(_toAddress, _amount);
        _toAddress.transfer(_amount);
    }

    //lock ownership changeing
    function renounceOwnership() public view override(Ownable) onlyOwner {
        revert("Can't Renounce Ownership here!!!");
    }
}