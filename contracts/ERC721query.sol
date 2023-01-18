//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

/**
    @dev: Alessandro De Cristofaro
    Easily get all the owned NFTs of a specific user
    Note: this contract must be used only for external calls ( DAPPs or off-chain softwares )
    Instead of looping IERC721Enumerable.tokenOfOwnerByIndex by using off-chain systems,
    using this contract we can leverage the on-chain reading speed and uses it in our frontend.
    The contract enable us to query all the collection (with interface IERC721Enumerable) on a specific chain.
 */

import "@openzeppelin/contracts/token/ERC721/extensions/IERC721Enumerable.sol";

contract ERC721query {
    /**
        Pass the collection and the user we want to query and receive back an array containing all the owned nfts
     */
    function getOwnedTokens( address _collection, address owner ) external view returns(uint[] memory) {
        if( ! _isContract(_collection ) ) revert("NOT_CONTRACT");
        IERC721Enumerable collection = IERC721Enumerable(_collection);
        uint balance = collection.balanceOf(owner);
        uint[] memory tokens = new uint[](balance);
        for(uint i = 0; i < balance; i++)
            tokens[i] = collection.tokenOfOwnerByIndex(owner, i);
        return tokens;
    }

    /** check if the collection address is a contract */
    function _isContract(address _addr) internal view returns (bool isContract){
        uint32 size;
        assembly {
            size := extcodesize(_addr)
        }
        return (size > 0);
    }
}