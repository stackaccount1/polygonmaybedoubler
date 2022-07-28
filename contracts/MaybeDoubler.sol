// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./Ownable.sol";
import "./VRFCoordinatorV2Interface.sol";

contract MaybeDoubler is Ownable {
    address public constant VRF_CONTRACT = 0xb8949d5685588fd73Fd002585D9f18F48c0078Fa;
    VRFCoordinatorV2Interface VRFContract = VRFCoordinatorV2Interface(VRF_CONTRACT);
    uint256 rand = 0;
    
    function testCall() public returns (uint256) {
        //This is example and not related to your contract
        rand = VRFContract.requestRandomWords(0xd89b2bf150e3b9e13446986e571fb9cab24b13cea0a43ea20a6049a85cc807cc, 1178, 2, 100000, 1);
        return rand;
    }
}