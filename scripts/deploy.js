const { ethers } = require("hardhat");

async function main() {
    const ethCT = await ethers.deployContract("EthCT");
    await ethCT.waitForDeployment();

    console.log(
        `Contract deployed to ${ethCT.target}`
    );
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});

// Contract deployed to 0x5FbDB2315678afecb367f032d93F642f64180aa3