# NFT Project with IPFS & Interactive SVG NFTs

This project consists of two different implementations of NFTs using the ERC721 standard. One version stores metadata on **IPFS**, while the other features **interactive SVG-based NFTs** that allow dynamic changes via the `flipMood()` function.

## 🚀 Features

### 🖼️ IPFS-Based NFT
- **IPFS Storage**: Each NFT’s metadata is stored securely on IPFS, making it relatively decentralized and immutable.
- **Image Metadata**: The metadata includes an image URI that points to the file stored on IPFS.

### 🖌️ Interactive SVG NFT
- **Dynamic SVGs**: The NFTs are built using on-chain SVGs that can be changed by interacting with the contract.
- **flipMood() Function**: Users can call `flipMood()` to change the mood of their NFT, offering an interactive experience.
- **Base64 Encoding**: The metadata for each NFT is stored onchain in a base64 encoded format using the `data:application/json;base64,` prefix.
- **Image URI**: The minter provides an image URI with a base64 encoded SVG in the format `data:image/svg+xml;base64,`.

## 📂 Project Structure

- **ERC721.sol**: Standard ERC721 contract for minting and managing NFTs.
- **IPFSNFT.sol**: NFT contract that stores metadata on IPFS.
- **InteractiveSVGNFT.sol**: NFT contract that generates and interacts with SVGs dynamically on-chain.

## 📜 How It Works

### 🖼️ IPFS NFT
1. The metadata for each minted NFT should be uploaded to **IPFS** and a link should be provided by the user.
2. The metadata should include JSON format, containing attributes such as the name, description, and an image URI that points to IPFS.

### 🖌️ Interactive SVG NFT
1. Each NFT is generated on-chain with an SVG image stored as base64 encoded data.
2. The `flipMood()` function allows users to interact with their NFT and change its visual state.

## 🔧 Usage

1. **Minting IPFS NFTs**: You can mint an NFT with metadata that is stored on IPFS using the **BasicNft.sol** contract.
2. **Minting Interactive SVG NFTs**: You can mint an SVG-based interactive NFT and change its mood via the `flipMood()` function, with the **MoodNf.sol** contract.

## 🔑 Key Functions

### BasicNft Contract
- **`mint()`**: Mints a new NFT with metadata stored on IPFS.
  
### MoodNf Contract
- **`flipMood()`**: Changes the mood of the NFT.
- **`mint()`**: Mints a new NFT with base64 encoded SVG and metadata.

## 🛠️ Tools Used

- **Solidity**: Smart contract language.
- **Foundry**: Development toolchain.
- **IPFS**: Decentralized file storage for NFT metadata.
- **SVG**: Scalable Vector Graphics used for on-chain NFT rendering.
- **Base64 Encoding**: Used for encoding metadata and images.

## 📄 License
MIT License

## ⬇️ Installation

### Clone the repository:
```bash
git clone https://github.com/VasilGrozdanov/merkle-aidrop.git
```

## 🛠️ Usage

### 🔨 Build
Use the [Makefile](https://github.com/VasilGrozdanov/foundry-nft/blob/main/Makefile) commands **(📝 note: Make sure you have GNU Make installed and add the necessary environment variables in a `.env` file)**, or alternatively foundry commands:
```shell
$ forge build
```

### 🧪 Test

```shell
$ forge test
```

### 🎨 Format

```shell
$ forge fmt
```

### ⛽ Gas Snapshots

```shell
$ forge snapshot
```

### 🔧 Anvil

```shell
$ anvil
```

### 🚀 Deploy
 BasicNft:
```shell
$ forge script script/DeployBasicNft.s.sol --rpc-url <your_rpc_url> --private-key <your_private_key> --broadcast
```
MoodNft:
```shell
$ forge script script/DeployMoodNft.s.sol --rpc-url <your_rpc_url> --private-key <your_private_key> --broadcast
```
> ⚠️ **Warning: Using your private key on a chain associated with real money must be avoided!**

 OR
 BasicNft:
```shell
$ forge script script/DeployBasicNft.s.sol --rpc-url <your_rpc_url> --account <your_account> --broadcast
```
MoodNft:
```shell
$ forge script script/DeployMoodNft.s.sol --rpc-url <your_rpc_url> --account <your_account> --broadcast
```
> 📝 **Note: Using your --account requires adding wallet first, which is more secure than the plain text private key!**
```Bash
cast wallet import --interactive <name_your_wallet>
```
### 🛠️ Cast

```shell
$ cast <subcommand>
```

### ❓ Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```
