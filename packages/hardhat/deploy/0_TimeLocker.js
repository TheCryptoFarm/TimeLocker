module.exports = async ({ getNamedAccounts, deployments }) => {
  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();
  await deploy("TimeLocker", {
    // Learn more about args here: https://www.npmjs.com/package/hardhat-deploy#deploymentsdeploy
    from: deployer,
    args: [
      "[token address you wish to lock]",
      "[wallet address where to send tokens when they can be released",
      "[block epoch time of release]",
    ],
    log: true,
  });
};
module.exports.tags = ["TimeLocker"];

/*
To Lock CAKE on BSC MAINNET
Sending to The CryptoFarm Donation Wallet 
Releases at Eastern Time Zone at Midnight on January 1st, 2022

args: ["0x0E09FaBB73Bd3Ade0a17ECC321fD13a19e81cE82", 
       "0x2E957A1e491718E10b71b704bb934465E788C462", 
       "1641013200"
],

*/
