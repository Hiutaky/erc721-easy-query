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
    const collectionToFetch = "0xF87A517A5CaecaA03d7cCa770789BdB61e09e05F"
    const userToFetch = "0xA90aa632c7928Eb4caFe8FE71fb30cD7bD033C46"
    const easyQuery = new ethers.Contract(contractAddress, contractAbi, signer )
    export const getTokens = async ({
        contractAddress,
        userAddress
    }) => {
        const pages = await easyQuery.getPages(contractAddress, userAddress)
        let tokens = []
        for( let i = 0; i <= pages; i++ )
            tokens = tokens.concat( await easyQuery.getOwnedTokens(
                contractAddress,
                userAddress,
                i
            ) )
        tokens = tokens.map( tokenId => tokenId.toString())
        return tokens
    }

    console.log(
        await getTokens({
            contractAddress: collectionToFetch,
            userAddress: ""
        })
    )
```

