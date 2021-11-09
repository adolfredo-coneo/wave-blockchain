const main = async () => {
  const [owner, randomPerson] = await hre.ethers.getSigners();
  const waveContractFactory = await hre.ethers.getContractFactory('WavePortal');
  const waveContract = await waveContractFactory.deploy();
  await waveContract.deployed();

  console.log('WavePortal Contract deployed to:', waveContract.address);
  console.log('WavePortal Contract deployed by:', owner.address);

  let waveCount;
  waveCount = await waveContract.getTotalWaves();

  //Adding waves
  let waveTxn = await waveContract.wave('This is the end!');
  await waveTxn.wait();
  waveCount = await waveContract.getTotalWaves();

  waveTxn = await waveContract.connect(randomPerson).wave('Nothing last forever, even cold november rain');
  await waveTxn.wait();
  waveCount = await waveContract.getTotalWaves();

  const waversList = await waveContract.getAllWaves();
  console.log('Wavers:', waversList);
};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.error(error);
    process.exit(1);
  }
};

runMain();
