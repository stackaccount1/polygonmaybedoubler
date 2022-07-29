// SPDX-License-Identifier: MIT
// Practice Solidity Writing
pragma solidity ^0.8.0;

import "./Ownable.sol";

contract TruthMachine is Ownable {
    event submit_Truth(uint id, string _title);
    event mint_Voters(address proleteriat);
    event vote_Truth(uint256 proposedTruthId, bool trueOrFalse);
    event tally_VotesVerifyTruth(uint256 proposedTruthId, bool trueOrFalse);
    event return_Votes(uint256 votes);
    event view_Truth(uint256 proposedTruthId, bool trueOrFalse);
    event view_Title(string title);

    struct Truth {
        address who;
        string url;
        string title;
        bool trueResult;
        uint256 votes;
        uint idNo;
    }

    Truth[] public truths;

    uint256 truthCount = 0;
    uint256 voterCount = 0;
    
    mapping (uint => address) public voterList;
    mapping (address => bool) public voterBool;
    mapping (address => mapping (uint => bool)) public proposalRecord;


    modifier onlyVoter(address proleteriat) {
        require(voterBool[proleteriat] = true);
        _;
    }

    function mintVoters(address proleteriat) public onlyOwner {
        voterList[voterCount] = proleteriat;
        voterCount++;    
    }

    function submitTruth(string memory _url, string memory _title) public returns (uint) {
        truths.push(Truth(msg.sender, _url, _title, false, 0, truthCount));
        //truthList[id] = truths[id];
        truthCount++;
        emit submit_Truth(truthCount, _title);
        return truthCount;
    }

    function voteTruth(uint256 _id) external onlyVoter(msg.sender) {
        Truth storage myTruth = truths[_id];
        require(proposalRecord[msg.sender][_id] == false);
        proposalRecord[msg.sender][_id] = true;
        myTruth.votes++;
    }

    function tallyVotesVerifyTruth (uint256 _id) public {
        Truth storage myTruth = truths[_id];
        uint256 halfVoters = voterCount / 2;
        if (myTruth.votes > halfVoters) {
            myTruth.trueResult = true;
        }
    }
    function returnVotes(uint256 _id) public view returns (uint256) {
        Truth storage myTruth = truths[_id];
        return myTruth.votes;
    }
    function returnTruth(uint256 _id) public view returns (bool) {
        Truth storage myTruth = truths[_id];
        return myTruth.trueResult;
    }
    function returnTitle(uint256 _id) public view returns (string memory) {
        Truth storage myTruth = truths[_id];
        return myTruth.title;
    }
}
