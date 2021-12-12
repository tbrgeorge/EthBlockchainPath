const ProductManager = artifacts.require("./ProductManager.sol");
contract("ItemManager", accounts => {
    it("... should let you create new Products.", async () => {
        const productManagerInstance = await ProductManager.deployed(); 
        const productName = "test1";
        const productPrice = 500;

        const result = await productManagerInstance.createProduct(productName, productPrice, {from: accounts[0] });
        assert.equal(result.logs[0].args._productIndex, 0, "There should be one product index in there");
        const product = await productManagerInstance.products(0);
        assert.equal(product._identifier, productName, "The product has a different identifier");
    });
});