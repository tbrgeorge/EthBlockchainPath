import React, { Component } from "react";
import ProductManagerContract from "./contracts/ProductManager.json";
import ProductContract from "./contracts/Product.json";
import getWeb3 from "./getWeb3";

import "./App.css";

class App extends Component {

  state = {cost: 0, productName: "exampleProduct1", loaded:false};

  componentDidMount = async () => {
    try {
      // Get network provider and web3 instance.
      this.web3 = await getWeb3();

      // Use web3 to get the user's accounts.
      this.accounts = await this.web3.eth.getAccounts();

      // Get the Manager contract instance.
      this.networkId = await this.web3.eth.net.getId();
      this.productManager = new this.web3.eth.Contract(
        ProductManagerContract.abi,
        ProductManagerContract.networks[this.networkId] && ProductManagerContract.networks[this.networkId].address,
      );

      // Get the Product contract instance.
      this.product = new this.web3.eth.Contract(
        ProductContract.abi,
        ProductContract.networks[this.networkId] && ProductContract.networks[this.networkId].address,
      );

      this.listenToPaymentEvent();
      this.setState({ loaded:true });
    } catch (error) {
      // Catch any errors for any of the above operations.
      alert(
        `Failed to load web3, accounts, or contract. Check console for details.`,
      );
      console.error(error);
    }
  };

  //send transactions to the network/ async waits the blockchain to come with a result
  handleSubmit = async () => {
    const { cost, productName } = this.state;
    console.log(productName, cost, this.productManager);
    let result = await this.productManager.methods.createProduct(productName, cost).send({ from: this.accounts[0] });
    console.log(result);
    alert("Send "+cost+" Wei to "+result.events.SupplyChainState.returnValues._address);
  };

  //set correctly all input variables
  handleInputChange = (event) => {
    const target = event.target;
    const value = target.type === 'checkbox' ? target.checked : target.value; const name = target.name;
      this.setState({
        [name]: value
    });
  }

  listenToPaymentEvent = () => {
    let self = this;
    this.productManager.events.SupplyChainState().on("data", async function(evt) {
      if(evt.returnValues._step == 1) {
        let product = await self.productManager.methods.products(evt.returnValues._productIndex).call();
        console.log(product);
        alert("Item " + product._identifier + " was paid, deliver it now!");
      };
      console.log(evt);
    });
  }

  render() {
    if (!this.state.loaded) {
      return <div>Loading Web3, accounts, and contract...</div>;
    }
    return (
      <div className="App">
        <h1>Event Trigger / Supply Chain Example</h1>
        <h2> Products </h2>
        <h2> Add products </h2>
        Cost in Wei: <input type="text" name="cost" value={this.state.cost} onChange={this.handleInputChange}/>
        Product indentifier: <input type="text" name="productName" value={this.state.productName} onChange={this.handleInputChange}/>
        <button type="button" onClick={this.handleSubmit}>Create new product</button>
      </div>
    );
  }
}

export default App;