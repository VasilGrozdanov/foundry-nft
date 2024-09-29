//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract MoodNft is ERC721 {
    enum Mood {
        HAPPY,
        SAD
    }

    uint256 public s_tokenCounter;
    string private s_sadSvg;
    string private s_happySvg;

    mapping(uint256 => Mood) private s_tokenIdToMood;

    constructor(
        string memory sadSvgImageUri,
        string memory happySvgImageUri
    ) ERC721("Mood Nft", "MOOD") {
        s_tokenCounter = 0;
        s_happySvg = happySvgImageUri;
        s_sadSvg = sadSvgImageUri;
    }

    event MoodChanged(uint256 tokenId, Mood newMood);

    error MoodNft__CantChangeMoodIfNotOwner();

    modifier isAuthorized(uint256 tokenId) {
        if (!_isAuthorized(_ownerOf(tokenId), msg.sender, tokenId)) {
            revert MoodNft__CantChangeMoodIfNotOwner();
        }
        _;
    }

    function mintNft() public {
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenIdToMood[s_tokenCounter] = Mood.HAPPY;
        s_tokenCounter++;
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        string memory imageURI;
        if (s_tokenIdToMood[tokenId] == Mood.HAPPY) {
            imageURI = s_happySvg;
        } else {
            imageURI = s_sadSvg;
        }
        return
            string.concat(
                _baseURI(),
                Base64.encode(
                    bytes(
                        string.concat(
                            '{"name": ',
                            name(),
                            ',"description": "An NFT that reflects the owners mood."',
                            ', "attributes": ',
                            '[{"trait_type": "moodiness", "value": "100"}], "image": "',
                            imageURI,
                            '"}'
                        )
                    )
                )
            );
    }

    function flipMood(uint256 tokenId) external isAuthorized(tokenId) {
        Mood newModod = s_tokenIdToMood[tokenId] == Mood.HAPPY
            ? Mood.SAD
            : Mood.HAPPY;
        s_tokenIdToMood[tokenId] = newModod;
        emit MoodChanged(tokenId, newModod);
    }

    function getTokenMood(uint256 tokenId) public view returns (Mood mood) {
        return s_tokenIdToMood[tokenId];
    }

    function getTokenCounter() public view returns (uint256) {
        return s_tokenCounter;
    }
}
