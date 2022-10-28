require("babel-register");
require("babel-polyfill");

// We're settings up our networks to the Ganache Network
module.exports = {
	networks: {
		development: {
			host: "127.0.0.1",
			port: "7545",
			network_id: "*", // Connect to any network
		},
	},

	// The path of contracts folder
	contracts_directory: "./src/contracts",

	// The path of all our JSON Files
	contracts_build_directory: "./src/build/contracts",

	compilers: {
		solc: {
			version: "^0.8.0",
			optimizer: {
				enabled: true,
				runs: 200,
			},
		},
	},
};
