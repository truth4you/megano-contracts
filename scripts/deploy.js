const { ethers } = require("hardhat");

async function main() {
  const [ owner ] = await ethers.getSigners();
  console.log("Deploying the contracts with %s on %s",owner.address,network.name)

  console.log("Account balance:", (await owner.getBalance()).toString());
  
  const tokenFactory = await ethers.getContractFactory("MEGANO");
  const tokenContract = await tokenFactory.deploy();
  await tokenContract.deployed();
  await (await tokenContract.transferOwner("0xe03C8Ca515b012825172D3C3aD56b3AD28832202")).wait();
  console.log("token", tokenContract.address)

  const presaleFactory = await ethers.getContractFactory("Crowdsale");
  const presaleContract = await presaleFactory.deploy("100", owner.address, tokenContract.address);
  await presaleContract.deployed();
  await (await presaleContract.transferOwner("0xe03C8Ca515b012825172D3C3aD56b3AD28832202")).wait();
  console.log("presale", presaleContract.address)
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
