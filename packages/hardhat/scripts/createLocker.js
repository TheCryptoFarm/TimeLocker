const hre = require("hardhat");
const ethers = hre.ethers;

const main = async () => {
  console.log("📡 Creating Locker...\n");
  const TLF = await hre.ethers.getContract("TimeLockerFactory");
  const receipt = await TLF.deployTimeLocker("1636452622");
  console.log("Your TX Hash: ", receipt.hash);
  console.log("-FIN-\n");
};

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
