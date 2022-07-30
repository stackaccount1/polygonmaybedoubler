// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./Ownable.sol";

contract MaybeDoubler is Ownable {
    address public constant VRF_Contract = 0x8838e75601d31e8025Eb6ad032a0A6834D559E10;
    uint256 rand = 0;
    
    function testCall() public returns (uint256) {
        //This is example and not related to your contract
        VRF_Contract.requestRandomWords();

        return rand;
    }
}