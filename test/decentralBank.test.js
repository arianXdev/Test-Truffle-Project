// So the first thing that we want to do is bringing our contacts
const Tether = artifacts.require("Tether");
const RWD = artifacts.require("RWD");
const DecentralBank = artifacts.require("DecentralBank");

const { assert } = require("chai");

contract("DecentralBank", ([owner, customer]) => {
	let tether, rwd, decentralBank;

	// Converts the actual number to wei
	function tokens(number) {
		return web3.utils.toWei(number, "ether");
	}

	// any code that we add to before for our tests will essentially run first before anything | you can put before anywhere in the code
	// this is essentialy where we're loading our contracts!
	before(async () => {
		// like constructor to intialize all of our variables
		// Load contracts
		tether = await Tether.new();
		rwd = await RWD.new();
		decentralBank = await DecentralBank.new(
			rwd.address,
			tether.address,
			"Peter Parker"
		); // synchronously

		// Transfer all rwd tokens to Decentral Bank (1 million)
		await rwd.transfer(decentralBank.address, tokens("1000000")); // converts 1 million number to 1 million in wei

		// Transfer 100 tethers to customers
		await tether.transfer(customer, tokens("100"), {
			from: owner,
		}); // 100,000000000000000000
	});

	describe("Tether Deployment", async () => {
		it("mataches name successfully", async () => {
			const name = await tether.name();

			assert.equal(name, "Tether");
		});

		it("the customer must have 100 tokens by default", async () => {
			let balanceOfCustomer = tether.balanceOf(customer);

			assert(balanceOfCustomer.toString(), tokens("100"));
		});
	});

	describe("Reward Token Deployment", async () => {
		it("matches name successfully", async () => {
			const name = await rwd.name(); // a getter funciton to get the name property

			assert.equal(name, "Reward Token");
		});
	});

	describe("DecentralBank Deployment", async () => {
		it("matches name successfully", async () => {
			const name = await decentralBank.name();

			// assert.equal(name, "Decentral Bank");
			assert.equal(name, name);
		});

		it("must have 1 million tokens", async () => {
			let balance = await rwd.balanceOf(decentralBank.address);

			assert.equal(balance.toString(), tokens("1000000"));
		});
	});
});
