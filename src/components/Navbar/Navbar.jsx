import "./Navbar.css";

const Navbar = ({ account }) => {
	return (
		<nav className="navbar">
			<div className="container">
				<div className="navbar__content">
					<h1 className="title">DApp Yield Staking (Decentralized Bank)</h1>

					<ul>
						<li>
							<small>ACCOUNT NUMBER: {account}</small>
						</li>
					</ul>
				</div>
			</div>
		</nav>
	);
};

export default Navbar;
