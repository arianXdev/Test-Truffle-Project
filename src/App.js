import { useState, useEffect } from "react";
import Web3 from "web3";

import { Navbar } from "./components";

import "./App.css";

const App = () => {
	// The Ethereum Acccount address of our customer (investor, client)
	const [account, setAccount] = useState("0x0");

	const loadWeb3 = async () => {
		if (window.ethereum) {
			window.web3 = new Web3(window.ethereum);
			await window.ethereum.enable();
		} else if (window.web3) {
			window.web3 = new Web3(window.web3.currenctProvider);
		} else {
			alert("No Ethereum browser detected! You can check out MetaMask!");
		}
	};

	const loadBlockchainData = async () => {
		const web3 = window.web3;
		const account = await web3.eth.getAccounts();

		console.log(account);
	};

	useEffect(() => {
		const fetchData = async () => {
			await loadWeb3();
			await loadBlockchainData();
		};

		fetchData();
	}, []);

	return (
		<div>
			<Navbar account={account} />
		</div>
	);
};

export default App;
