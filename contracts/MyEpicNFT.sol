// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.1;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

contract MyEpicNFT is ERC721URIStorage {

    using Counters for Counters.Counter;
    Counters.Counter private _tokenId; // Counter for the no. of NFTs

    constructor() ERC721 ("SquareNFT","SQR") { // NFT name and NFT symbol
        console.log("This is my Contract. Whoa!");
    }

    // Mint an NFT
    function makeAnEpicNFT() public {           
        uint256 newItemId = _tokenId.current(); // temporary variable to get current NFT id

        _safeMint(msg.sender, newItemId);   // Mint NFT

        _setTokenURI(newItemId, "https://jsonkeeper.com/b/GP6J");    // Set NFT id and metadata-> JSON Keeper
        console.log("NFT with id %s is minted by %s", newItemId, msg.sender); // For our reference

        _tokenId.increment();   // Increase count of NFT

    }
}