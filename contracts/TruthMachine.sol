// SPDX-License-Identifier: MIT
// Practice Solidity Writing
pragma solidity ^0.8.0;

import "./Ownable.sol";

contract MaybeDoubler is Ownable {
    event submitTruth(string x);
    event mintVoters(address proleteriat);
    event voteTruth(uint256 proposedTruthId, bool trueOrFalse);
    event tallyVotesVerifyTruth(uint256 proposedTruthId, bool trueOrFalse);
    event returnVotes(uint256 votes);
    event viewTruth(uint256 proposedTruthId, bool trueOrFalse):
    event viewTitle(string title);

    struct Truth {
        address who;
        string url;
        string title;
        bool trueResult;
        uint256 votes;
    }

    Truth[] public truths;

    uint256 truthCount = 0;
    uint256 voterCount = 0;
    
    mapping (uint => address) public voterList;
    mapping (uint => bool) public voterBool;
    mapping (uint => Truth) public truthList;


    function mintVoters(address proleteriat) public onlyOwner {
        
    } 
}
