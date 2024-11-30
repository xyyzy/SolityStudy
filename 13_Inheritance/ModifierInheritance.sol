// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract Base1{
    modifier exactDividedBy2And3(uint _a) virtual {
        require(_a %2 ==0 && _a %3==0);
        _;
    }
}
contract Identifier is Base1{
    function getExactDividedBy2And3(uint _dividend) public exactDividedBy2And3(_dividend) pure returns(uint,uint){
        return getExactDividedBy2And3WithoutModifier(_dividend);
    }
    function getExactDividedBy2And3WithoutModifier(uint _dividend) public pure returns(uint,uint){
        uint divid2 = _dividend /2;
        uint divid3 = _dividend /3;
        return(divid2,divid3);
    }
}