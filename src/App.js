import { useState } from "react";

import { Navbar } from "./components";

import "./App.css";

const App = () => {
	// The Ethereum Acccount address of our customer (investor, client)
	const [account, setAccount] = useState("0x0");

	return (
		<div>
			<Navbar account={account} />
		</div>
	);
};

export default App;
