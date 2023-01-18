# ERC721query: retrieve all the owned NFT tokens of a specific collection

Easily get all the owned NFTs of a specific user and speedup your Frontends.

Note: this contract must be used only for external calls ( DAPPs or off-chain softwares )

# How it works? 
Instead of looping IERC721Enumerable.tokenOfOwnerByIndex by using off-chain systems,
using this contract we can leverage the on-chain reading speed and uses it in our frontend.
The contract enable us to query all the collections (with interface IERC721Enumerable) on a specific chain.
