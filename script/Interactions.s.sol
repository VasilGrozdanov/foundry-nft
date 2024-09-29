//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {BasicNft} from "../src/BasicNft.sol";
import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {MoodNft} from "src/MoodNft.sol";

contract MintBasicNft is Script {
    string constant PUG =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function run() external returns (BasicNft) {
        address mostRecentDeployedBasicNFT = DevOpsTools
            .get_most_recent_deployment("BasicNft", block.chainid);
        BasicNft basicNFT = BasicNft(mostRecentDeployedBasicNFT);
        vm.startBroadcast();
        basicNFT.mintNft(PUG);
        vm.stopBroadcast();
        return basicNFT;
    }
}

contract MintMoodNft is Script {
    function run() external returns (MoodNft) {
        address mostRecentDeployeMoodNFT = DevOpsTools
            .get_most_recent_deployment("MoodNft", block.chainid);
        MoodNft moodNft = MoodNft(mostRecentDeployeMoodNFT);
        vm.startBroadcast(msg.sender);
        moodNft.mintNft();
        vm.stopBroadcast();
        return moodNft;
    }
}

contract FlipMoodNft is Script {
    error FlipMoodNft__SenderDoesNotOwnMoodNFT();

    function run() external returns (MoodNft.Mood) {
        return flipMood(findLastNft(msg.sender));
    }

    function flipMood(uint256 tokenId) public returns (MoodNft.Mood) {
        address mostRecentDeployeMoodNFT = DevOpsTools
            .get_most_recent_deployment("MoodNft", block.chainid);
        MoodNft moodNft = MoodNft(mostRecentDeployeMoodNFT);
        vm.startBroadcast();
        moodNft.flipMood(tokenId);
        vm.stopBroadcast();
        return moodNft.getTokenMood(tokenId);
    }

    function findLastNft(address owner) internal view returns (uint256) {
        address mostRecentDeployeMoodNFT = DevOpsTools
            .get_most_recent_deployment("MoodNft", block.chainid);
        MoodNft moodNft = MoodNft(mostRecentDeployeMoodNFT);

        if (moodNft.getTokenCounter() == 0 || moodNft.balanceOf(owner) == 0) {
            revert FlipMoodNft__SenderDoesNotOwnMoodNFT();
        }

        for (
            uint256 tokenId = moodNft.getTokenCounter() - 1;
            tokenId > 0;
            tokenId--
        ) {
            if ((moodNft.ownerOf(tokenId)) == owner) {
                return tokenId;
            }
        }
        return 0;
    }
}
