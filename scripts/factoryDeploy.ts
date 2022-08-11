import { ethers } from "hardhat";

async function main() {
  // const currentTimestampInSeconds = Math.round(Date.now() / 1000);
  // const ONE_YEAR_IN_SECS = 365 * 24 * 60 * 60;
  // const unlockTime = currentTimestampInSeconds + ONE_YEAR_IN_SECS;

  // const lockedAmount = ethers.utils.parseEther("1");

  let [valid1, valid2, valid3, valid4, valid5] = await ethers.getSigners();
  

  const MultisigFactory = await ethers.getContractFactory("MultiSigFactory");
  const multisigFactory = await MultisigFactory.deploy();

  await multisigFactory.deployed();

  console.log("Factory contract deployed to this address:", multisigFactory.address);
  let cloned = await multisigFactory.cloneMultiSig([valid1.address, valid2.address, valid3.address, valid4.address, valid5.address]);
  let clone2= await multisigFactory.connect(valid2).cloneMultiSig([valid1.address, valid2.address, valid3.address, valid4.address, valid5.address]);
  
  
  let result = (await  cloned.wait()).logs[0].topics.length;
  let result1 = (await  cloned.wait()).logs[0].topics[0];
  let result2 = (await  cloned.wait()).logs[0].topics[1];
  let result3 = (await  cloned.wait()).logs[0].topics[2];
  

  console.log("factory cloned successfully", result, result1, result2, result3);

  let clonedAddresses = await multisigFactory.clonedAddresses();
  let clonedAddressesResult = await clonedAddresses;

  console.log(clonedAddressesResult);



}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
