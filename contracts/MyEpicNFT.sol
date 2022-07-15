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

        _setTokenURI(newItemId, "data:application/json;base64,eyJuYW1lIjoiMldvcmRzIiwiZGVzY3JpcHRpb24iOiJCbGFjayBib3ggd2l0aCAyIHdoaXRlIHRleHRzIiwiaW1hZ2UiOiJkYXRhOmltYWdlL3N2Zyt4bWw7YmFzZTY0LFBITjJaeUI0Yld4dWN6MGlhSFIwY0RvdkwzZDNkeTUzTXk1dmNtY3ZNakF3TUM5emRtY2lJSEJ5WlhObGNuWmxRWE53WldOMFVtRjBhVzg5SW5oTmFXNVpUV2x1SUcxbFpYUWlJSFpwWlhkQ2IzZzlJakFnTUNBek5UQWdNelV3SWo0S0lDQWdJRHh6ZEhsc1pUNHVZbUZ6WlNCN0lHWnBiR3c2SUhkb2FYUmxPeUJtYjI1MExXWmhiV2xzZVRvZ2MyVnlhV1k3SUdadmJuUXRjMmw2WlRvZ01UUndlRHNnZlR3dmMzUjViR1UrQ2lBZ0lDQThjbVZqZENCM2FXUjBhRDBpTVRBd0pTSWdhR1ZwWjJoMFBTSXhNREFsSWlCbWFXeHNQU0ppYkdGamF5SWdMejRLSUNBZ0lEeDBaWGgwSUhnOUlqVXdKU0lnZVQwaU5UQWxJaUJqYkdGemN6MGlZbUZ6WlNJZ1pHOXRhVzVoYm5RdFltRnpaV3hwYm1VOUltMXBaR1JzWlNJZ2RHVjRkQzFoYm1Ob2IzSTlJbTFwWkdSc1pTSStTR1ZzYkVKeWFXNW5aWEk4TDNSbGVIUStDand2YzNablBnPT0ifQ==");    // Set NFT id and metadata-> JSON Keeper(changed to encoded SVG's)
        console.log("NFT with id %s is minted by %s", newItemId, msg.sender); // For our reference

        _tokenId.increment();   // Increase count of NFT

    }
}