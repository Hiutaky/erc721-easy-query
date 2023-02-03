# ERC721query: retrieve in 1 shot all the User's Owned Token Ids of a NFT collection

Easily get all the owned NFTs of a specific user and speedup your Frontends.

Note: this contract must be used only for external calls ( DAPPs or off-chain softwares )

# How it works? 
Instead of looping IERC721Enumerable.tokenOfOwnerByIndex by using off-chain systems,
using this contract we can leverage the on-chain reading speed and uses it in our frontend.
The contract enable us to query all the collections (with interface IERC721Enumerable) on a specific chain.

# Code example

After having implemented the contract in the frontend using a library like ethers.js:

Get all the tokens of a specific collection owned by an user
```
    const ERC721Utils = new ethers.Contract(contractAddress, contractAbi, signer )
    const getAllNfts = async (accountAddress, contractToQuery) => {
        let ids = await ERC721Utils.getOwnedTokens(
            contractToQuery.address, // .address is needed if contractToQuery is a ethers.Contract instance
            accountAddress
        )
        return ids
    }
```

