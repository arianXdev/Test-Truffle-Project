const Tether = artifacts.require("Tether");
const RWD = artifacts.require("RWD");
const DecentralBank = artifacts.require("DecentralBank");

module.exports = async function(deployer) {
	// Deploys Tether contract
	await deployer.deploy(Tether);

	// Deploys RWD contract
	await deployer.deploy(RWD);

	// Deploys DecentralBank contract
	await deployer.deploy(DecentralBank);
};
