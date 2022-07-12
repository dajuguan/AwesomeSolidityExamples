// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract MerkelProof{
    bytes32[] public hashes;
    uint public leafLength;
    event Hash(uint offset, bytes32 hash);

    function verify(uint index, bytes32[] memory proof) view public returns(bool){
        require(index < leafLength, 'index out of range');
        bytes32 hash = hashes[index];
        for (uint i = 0; i < proof.length; i++){
            bytes32 proofElement = proof[i];
            if (index % 2 == 0) {
                hash = keccak256(abi.encodePacked(hash, proofElement));
            } else {
                hash = keccak256(abi.encodePacked(proofElement, hash));
            }
            index = index >> 1; //equals index/2
        }
        return hash == getRoot();
    }

    function getProof(uint leafIndex) public view returns(bytes32[] memory){
        require(leafIndex < leafLength, 'index out of range');
        bytes32 hash;
        uint depth = 0;
        uint length = leafLength;
        // calculate the depth of the merkle tree, to init the proof with certain length
        while(length > 1) {
            length = length>>1;
            ++depth;
        }
        bytes32[] memory proof = new bytes32[](depth);

        // add proof in each depth 
        uint offset = leafIndex;
        length = leafLength;
        depth = 0;
        
        while (length >1) {
            if (leafIndex % 2 == 0) {
                hash = hashes[offset + 1];
            } else {
                hash = hashes[offset - 1];
            }
            proof[depth] = hash;
            // emit Hash(offset, hash);

            // the order is important: 1. calculated the index in the next depth 2. add the offset 3. go the next depth
            leafIndex = leafIndex >> 1;
            offset = leafIndex + length;
            length = length >> 1;   
            ++depth;
        }
        return proof;
    }

    function getRoot() public view returns(bytes32){
        return hashes[hashes.length -1];
    }
}

contract TestMerkelProof is MerkelProof {
    constructor () {
        string[4] memory txs = [
                    "a=>b",
                    "b->c",
                    "e->f",
                    "x->y"
                ];
        for (uint i=0; i< txs.length; i++){
            hashes.push(keccak256(abi.encodePacked(txs[i])));
        }
        leafLength = txs.length;
        uint n = leafLength;
        uint offset = 0;
        while ( n>0) {
            for(uint i=0; i< n-1; i+=2){
                hashes.push(
                    keccak256(
                        abi.encodePacked(hashes[offset + i], hashes[offset + i + 1])
                    ));
            }
            offset += n;
            n = n >> 1;
        }
    }
}