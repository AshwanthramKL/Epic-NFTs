const main = async() => {
    const nftContractFactory = await hre.ethers.getContractFactory("MyEpicNFT"); //Compiles contract
    const nftContract = await nftContractFactory.deploy();

    await nftContract.deployed();
    console.log('Contract deployed to :', nftContract.address); 

    let txn = await nftContract.makeAnEpicNFT();    // call minting function for the first time
    await txn.wait();   // wait for mint
    console.log('Minted First NFT!');

    txn = await nftContract.makeAnEpicNFT();    // call minting function for the second time
    await txn.wait();   // wait for mint
    console.log('Minted Second NFT!');

}; 

const runMain = async() => {
    try {
        await main();
        process.exit(0);
    } catch(error){
       console.log(error);
       process.exit(1); 
    }
};

runMain();