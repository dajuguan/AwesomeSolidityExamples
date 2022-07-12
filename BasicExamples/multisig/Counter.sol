// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

// Uniswap example
interface ICounter{
    function count() external view returns(uint);
    function increment() external;
}

contract Counter{
    uint public count;
    address payable owner;
    constructor(){
        owner = payable(msg.sender);
    }
    function increment() payable public returns(uint){
        count +=1;
        return count;
    }
    function getData() public pure returns(bytes memory){
        return abi.encodeWithSignature("increment()");        
    }

    function deposit() public payable {
    }
    function withdraw() public{
        uint amount = address(this).balance;
        (bool success, ) = owner.call{value:amount}("");
    }
    function getBlance() public view returns(uint){
        return address(this).balance;
    }
}

contract MyContract {
    function incCounter(address _counter)  public{
        ICounter(_counter).increment();
    }
    function getCount(address _counter) view public returns(uint x){
        x = ICounter(_counter).count();
    }
}