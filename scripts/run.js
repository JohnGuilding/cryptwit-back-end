const main = async () => {
    const cryptwitContractFactory = await hre.ethers.getContractFactory("Cryptwit");
    const cryptwitContract = await cryptwitContractFactory.deploy();
    await cryptwitContract.deployed();

    console.log("Contract deployed to:", cryptwitContract.address);

    const tweet = await cryptwitContract.tweet("This is a tweet");
    await tweet.wait();

    const allTweets = await cryptwitContract.getTweets();
    console.log(allTweets);
}

const runMain = async () => {
    try {
        await main();
        process.exit(0);
    } catch (error) {
        console.log(error);
        process.exit(1);
    }
}

runMain();