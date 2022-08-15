require("dotenv").config({ path: ".env" });
import { BytesLike } from "ethers";
import { ethers } from "hardhat";

// import * as dotenv from "dotenv";

// import IMultiSig from "../typechain-types/Imultisig.sol"

async function main() {
  const _value = ethers.utils.parseEther("1");

  const CONTRACTADDRESS = "0x6e828b59fc799b6ef92e42d2f39e438a7477f469";
    const MULTISIG = await ethers.getContractAt("IMultiSig", CONTRACTADDRESS);

  let [valid1, valid2] = await ethers.getSigners();

  const bal = await MULTISIG.contractBalance();
  console.log("contractBalance", bal);

  const helpers = require("@nomicfoundation/hardhat-network-helpers");

  
  const address1 = "0x7A3E0DFf9B53fA0d3d1997903A48677399b22ce7";
  await helpers.impersonateAccount(address1);
  const impersonatedSigner1= await ethers.getSigner(address1);


  const address2 = "0x9ee15CF9EC4B3830bBedA501d85F5329Ea3C595C";
  await helpers.impersonateAccount(address2);
  const impersonatedSigner2 = await ethers.getSigner(address2);


  const address3 = "0x85f20a6924A61904AB44243C7e2c771B3bE46734";
  await helpers.impersonateAccount(address3);
  const impersonatedSigner3 = await ethers.getSigner(address3);

  const address4 = "0x9ee15CF9EC4B3830bBedA501d85F5329Ea3C595C";
  await helpers.impersonateAccount(address4);
  const impersonatedSigner4 = await ethers.getSigner(address4);

  const address5 = "0x85f20a6924A61904AB44243C7e2c771B3bE46734";
  await helpers.impersonateAccount(address5);
  const impersonatedSigner5 = await ethers.getSigner(address5);

  const address6 = "0x2DBdd859D9551b7d882e9f3801Dbb83b339bFFD7";
  await helpers.impersonateAccount(address6);
  const impersonatedSigner6 = await ethers.getSigner(address6);

  const address7 = "0x9ee15CF9EC4B3830bBedA501d85F5329Ea3C595C";
  await helpers.impersonateAccount(address7);
  const impersonatedSigner7 = await ethers.getSigner(address7);

  const address8 = "0x88538EE7D25d41a0B823A7354Ea0f2F252AD0fAf";
  await helpers.impersonateAccount(address8);
  const impersonatedSigner8  = await ethers.getSigner(address8);


  const withdraw = await (await MULTISIG.connect(impersonatedSigner1).withdrawEther(_value)).wait();
  let impersonatedBalance = await impersonatedSigner1.getBalance();
  console.log(withdraw);


  const approve1 = await await MULTISIG.connect(impersonatedSigner2).Approve(8);
  const approve2 = await (await MULTISIG.connect(impersonatedSigner3)).Approve(8)
  const approve3 = await (await MULTISIG.connect(impersonatedSigner4)).Approve(8)
  const approve4 = await (await MULTISIG.connect(impersonatedSigner5)).Approve(8)
  const approve5 = await (await MULTISIG.connect(impersonatedSigner6)).Approve(8)
  const approve6 = await (await MULTISIG.connect(impersonatedSigner7)).Approve(8)
  const approve7 = await (await MULTISIG.connect(impersonatedSigner8)).Approve(8)
  

  console.log("impersonate bal", impersonatedBalance );
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});