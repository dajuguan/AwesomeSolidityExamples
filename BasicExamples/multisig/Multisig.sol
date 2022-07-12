// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract MultiSig{
    struct Tx {
        uint index;
        address _to;
        bytes data;
        uint numConfired;
        bool excecuted;
    }

    Tx[] public txs;
    address[] public owners;
    mapping(address => bool) isowner;
    mapping(uint => mapping(address => bool)) public isConfirmed;
    uint public minConfirmRequired;

    event ExecuteTx(address sender, bool success, bytes value);

    modifier onlyOwner(){
        require(isowner[msg.sender], 'Not owner');
        _;
    }
    modifier notExecuted(uint _txindex){
        require(!txs[_txindex].excecuted, 'tx already excuted!');
        _;
    }
    modifier notConfirmed(uint _txindex){
        require(!isConfirmed[_txindex][msg.sender], 'already confirmed');
        _;
    }
    constructor(address[] memory _owners, uint _minConfirmRequired ){
        for (uint i=0; i< _owners.length; i++){
            owners.push(_owners[i]);
            isowner[owners[i]] = true;
        }
        minConfirmRequired = _minConfirmRequired;
    }

    function submitTx(address _to, bytes memory data) public onlyOwner{
        uint index = txs.length;
        txs.push (Tx({
            index:index,
            _to:_to,
            data:data,
            excecuted:false,
            numConfired:0
        })
        );
    }

    function confirmTx(uint txIndex) public onlyOwner notExecuted(txIndex) notConfirmed(txIndex){
        Tx storage transaction = txs[txIndex];
        isConfirmed[txIndex][msg.sender] = true;
        transaction.numConfired += 1;
    }


    function executeTx(uint txIndex) public onlyOwner notExecuted(txIndex){
        Tx storage transction = txs[txIndex];
        require(transction.numConfired >= minConfirmRequired, 'cannot execute transction');
        transction.excecuted = true;
        (bool success, bytes memory value) = transction._to.call(transction.data);
        emit ExecuteTx(msg.sender, success, value);

    }
}