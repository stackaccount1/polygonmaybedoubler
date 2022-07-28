// SPDX-License-Identifier: MIT
// Practice Solidity Writing
pragma solidity ^0.8.0;

import "./Ownable.sol";

contract MaybeDoubler is Ownable {
    event submit_Truth(string x);
    event mint_Voters(address proleteriat);
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
    mapping (address => bool) public voterBool;
    mapping (uint => Truth) public truthList;

    modifier onlyVoter(address proleteriat) {
        require(voterBool[proleteriat] = true);
        _;
    }

    function mintVoters(address proleteriat) public onlyOwner {
        voterList[voterCount] = proleteriat;
        voterCount++;    
    }

    function submitTruth(string memory _url, string memory _title) public returns (uint) {
        uint256 id =  truths.push(Truth(msg.sender, _url, _title, false, 0);
        truthList[id] = truths[id];
        truthCount++;
        return id;
        emit submit_Truth(memory);
    }

    function voteTruth() public onlyVoter(msg.sender) {
        
    }
}
