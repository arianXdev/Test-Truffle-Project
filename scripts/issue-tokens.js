const DecentralBank = artifacts.require("DecentralBank");

module.exports = async function issueRewards(callback) {
	const decentralBank = await DecentralBank.deployed();
	await decentralBank.issueTokens();

	console.log("Tokens have been issued successfully!");
	callback();
};
