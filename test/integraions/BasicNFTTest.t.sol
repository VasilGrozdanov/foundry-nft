//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {console2} from "forge-std/Script.sol";
import {BasicNft} from "src/BasicNft.sol";
import {DeployBasicNft} from "script/DeployBasicNft.s.sol";

contract BasicNFTTest is Test {
    address public USER = makeAddr("User");
    BasicNft public basicNFT;

    function setUp() external {
        DeployBasicNft deployBasicNFT = new DeployBasicNft();
        basicNFT = deployBasicNFT.run();
    }

    function testInitialization() external {
        BasicNft newBasicNFT = new BasicNft();
        string memory expectedName = "Dogie";
        string memory expectedSymbol = "DOG";

        // assertEq(newBasicNFT.name(), expectedName);
        assert(
            keccak256(abi.encode(newBasicNFT.name())) ==
                keccak256(abi.encode(expectedName))
        );
        assertEq(newBasicNFT.symbol(), expectedSymbol);
        assertEq(newBasicNFT.s_tokenCounter(), 0);
    }

    function testMint(string memory uri) external {
        console2.log(basicNFT.s_tokenCounter());
        vm.prank(USER);
        basicNFT.mintNft(uri);
        console2.log(basicNFT.s_tokenCounter());

        assertEq(basicNFT.balanceOf(USER), 1);
        assertEq(basicNFT.tokenURI(0), uri);
        assertEq(basicNFT.s_tokenCounter(), 1);
    }
}
