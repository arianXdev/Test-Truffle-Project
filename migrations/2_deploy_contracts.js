const Tether = artifacts.require("Tether");
const RWD = artifacts.require("RWD");
const DecentralBank = artifacts.require("DecentralBank");

module.exports = async function(deployer, network, accounts) {
	// Deploys Tether contract
	await deployer.deploy(Tether);
	const tether = await Tether.deployed();

	// Deploys RWD contract
	await deployer.deploy(RWD);
	// We're going to wait to receive the RWD contract
	const rwd = await RWD.deployed();

	// Deploys DecentralBank contract
	await deployer.deploy(DecentralBank, rwd.address, tether.address);
	const decentralBank = await DecentralBank.deployed();

	// Transfer all RWD tokens to Decentral Bank
	// DecentralBank.address gives the contract address
	await rwd.transfer(decentralBank.address, "1000000000000000000000000"); // 1 million tokens

	// Distribute 100 Tether tokens to investor
	await tether.transfer(accounts[1], "100000000000000000000"); // 100 tokens
};
