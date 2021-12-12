pragma solidity ^0.6.0; 

import "./Ownable.sol";
import "./Product.sol"; 

contract ProductManager is Ownable {
    
    mapping(uint => S_Product) public products; 
    uint index;
    enum SupplyChainStates {Created, Paid, Delivered}
    event SupplyChainState(uint _productIndex, uint _state, address _address);

    struct S_Product {
        Product _product;
        ProductManager.SupplyChainStates _state;
        string _identifier; 
    }
    
    function createProduct(string memory _identifier, uint _priceInWei) public onlyOwner{
        Product product = new Product(this, _priceInWei, index);
        products[index]._product = product;
        products[index]._state = SupplyChainStates.Created; 
        products[index]._identifier = _identifier;
        emit SupplyChainState(index, uint(products[index]._state), address(product)); 
        index++;
    }

    function triggerPayment(uint _index) public payable {
        Product product = products[_index]._product;
        require(address(product) == msg.sender, "Only products are allowed to update themselves");
        require(product.priceInWei() == msg.value, "Not fully paid yet");
        require(products[_index]._state == SupplyChainStates.Created, "Product is further in the supply chain");
        products[_index]._state = SupplyChainStates.Paid;
        emit SupplyChainState(_index, uint(products[_index]._state), address(product)); 
    }

    function triggerDelivery(uint _index) public onlyOwner{
        require(products[_index]._state == SupplyChainStates.Paid, "Product is further in the supply chain");
        products[_index]._state = SupplyChainStates.Delivered;
        emit SupplyChainState(_index, uint(products[_index]._state), address(products[_index]._product)); 
    }

}