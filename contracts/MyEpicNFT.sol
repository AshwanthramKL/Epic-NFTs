// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.1;

import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

import { Base64 } from "./libraries/Base64.sol";

contract MyEpicNFT is ERC721URIStorage {

    using Counters for Counters.Counter;
    Counters.Counter private _tokenId; // Counter for the no. of NFTs

    // baseSvg variable for all the NFTs to access
    string baseSvg = "<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 350 350'><style>.base { fill: white; font-family: serif; font-size: 24px; }</style><rect width='100%' height='100%' fill='black' /><text x='50%' y='50%' class='base' dominant-baseline='middle' text-anchor='middle'>";
    
    string[] firstWords = ["Astonishing", "Brilliant", "Striking", "Elegant", "Exquisite", "Flawless", "Dynamite", "Marvelous", "Glorious", "Polished", "Unreal", "Graceful", "Hip", "Sharp", "Bewitching"];
    string[] secondWords = ["Bumblebee", "Clandestine", "Crestfallen", "Diabolical", "Flippant", "Incognito", "Kaleidoscope", "Mercury", "Onomatopoeia", "Stoic", "Villain", "Wizard", "Entrepreneur", "Goku", "Fireball"];
    string[] thirdWords = ["bannister", "alkaliser", "bartender", "bootmaker", "caretaker", "carpooler", "complexer", "killer", "vanquisher", "disguiser", "enchanter", "foxhunter", "fighter", "lifesaver", "shotmaker"];


    constructor() ERC721 ("SquareNFT","SQR") { // NFT name and NFT symbol
        console.log("NFT Generating\n");
    }

    // Return a random index number 
    function random(string memory input) internal pure returns(uint256) {
        return uint256(keccak256(abi.encodePacked(input)));

    }

    // Randomly generates first word 
    function pickRandomFirstWord(uint256 tokenId) public view returns (string memory) {
     
    uint256 rand = random(string(abi.encodePacked("FIRST_WORD", Strings.toString(tokenId)))); // Passes "FIRST_WORD" and tokenId as parameters to random function

    rand = rand % firstWords.length; // double hashing
    
    string memory first_word = firstWords[rand];

    return first_word;
    }

    // Randomly generates second word
    function pickRandomSecondWord(uint256 tokenId) public view returns (string memory) {

        uint256 rand = random(string(abi.encodePacked("SECOND_WORD", Strings.toString(tokenId))));

        rand = rand % secondWords.length;

        string memory secondWord = secondWords[rand];

        return secondWord;
    }

    // Randomly generates third word
    function pickRandomThirdWord(uint256 tokenId) public view returns (string memory) {

        uint256 rand = random(string(abi.encodePacked("THIRD_WORD", Strings.toString(tokenId))));

        rand = rand % thirdWords.length;

        string memory thirdWord = thirdWords[rand];

        return thirdWord;
    }


    // Mint an NFT
    function makeAnEpicNFT() public {           
        uint256 newItemId = _tokenId.current(); // temporary variable to get current NFT id

        string memory firstWord = pickRandomFirstWord(newItemId);
        string memory secondWord = pickRandomSecondWord(newItemId);
        string memory thirdWord = pickRandomThirdWord(newItemId);
        string memory finalWord = string(abi.encodePacked(firstWord, secondWord, thirdWord));

        string memory finalSvg = string(abi.encodePacked(baseSvg, finalWord, "</text></svg>")); // concatinating all the components of the Svg
        
        // Get all the JSON metadata in place and base64 encode it.
        string memory json = Base64.encode(
            bytes(
                string(
                    abi.encodePacked(
                        '{ "name": "', finalWord,'",', // title = finalWord
                        '"description": "A cool collection of black sqaure with kickass character names", ',
                        '"image": "data:image/svg+xml;base64,',Base64.encode(bytes(finalSvg)),'" }' // adding the encoded svg as image
                    )
                )
            )
        );

        string memory finalTokenURI = string(abi.encodePacked("data:application/json;base64,", json));
        console.log(finalTokenURI);     
        console.log("\n----------------------------------");


        _safeMint(msg.sender, newItemId);   // Mint NFT

        _setTokenURI(newItemId, finalTokenURI); // Will be set in next stage 
        console.log("NFT with id %s is minted by %s", newItemId, msg.sender); // For our reference

        _tokenId.increment();   // Increase count of NFT

    }
}