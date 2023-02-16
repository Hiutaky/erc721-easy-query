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

    uint public tokenPerPage = 20;

    function getOwnedTokens( address _collection, address owner, uint page ) external view returns(uint[] memory) {
        if( ! _isContract(_collection ) ) revert("NOT_CONTRACT");
        IERC721Enumerable collection = IERC721Enumerable(_collection);
        uint balance = collection.balanceOf(owner);
        uint[] memory empty = new uint[](0);
        if( balance == 0) return empty;
        uint startIndex = page > 0 ? tokenPerPage * page : 0;
        uint toQuery = 
            balance < tokenPerPage ?
                balance : 
                page > 0 ? 
                    tokenPerPage * ( page + 1) :
                    tokenPerPage;
        
        toQuery = toQuery > balance ? balance : toQuery;
        uint delta = toQuery - startIndex;
        uint[] memory tokens = new uint[](delta);
        for(uint i = 0; i + startIndex < toQuery; i++)
            tokens[i] = collection.tokenOfOwnerByIndex(owner, startIndex + i);
        return tokens;
    }

    function getPages(address _collection, address owner) external view returns(uint) {
        IERC721Enumerable collection = IERC721Enumerable(_collection);
        uint balance = collection.balanceOf(owner);
        uint pages = balance > 0 ? balance / tokenPerPage : 0;
        bool hasOffset = balance > 0 ? pages * tokenPerPage == balance ? false : true : false;
        pages = hasOffset ? pages++ : pages; 
        return pages;
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