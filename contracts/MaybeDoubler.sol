// SPDX-License-Identifier: MIT
// An example of a consumer contract that relies on a subscription for funding.
pragma solidity ^0.8.7;

import "./VRFCoordinatorV2Interface.sol";
import "./VRFConsumerBaseV2.sol";

/**
 * THIS IS AN EXAMPLE CONTRACT THAT USES HARDCODED VALUES FOR CLARITY.
 * THIS IS AN EXAMPLE CONTRACT THAT USES UN-AUDITED CODE.
 * DO NOT USE THIS CODE IN PRODUCTION.
 */

contract MaybeDoubler is VRFConsumerBaseV2 {
  VRFCoordinatorV2Interface COORDINATOR;
  //events
  event win(address player, uint256 winnings);
  event lose(address player);
  // Your subscription ID.
  uint64 s_subscriptionId;
  address vrfCoordinator = 0x7a1BaC17Ccc5b313516C5E16fb24f7659aA5ebed;
  bytes32 keyHash = 0x4b09e658ed251bcafeebbc69400383d49f344ace09b9576fe248bb02c003fe9f;
  uint32 callbackGasLimit = 100000;
  uint16 requestConfirmations = 3;
  uint32 numWords = 1;
  uint256[] public s_randomWords;
  uint256 public s_requestId;
  address s_owner;
  uint256 public idNumber = 0;
  mapping (uint256 => address) idToCaller;
  mapping (uint256 => uint256) idToWager;

  constructor(uint64 subscriptionId) VRFConsumerBaseV2(vrfCoordinator) {
    COORDINATOR = VRFCoordinatorV2Interface(vrfCoordinator);
    s_owner = msg.sender;
    s_subscriptionId = subscriptionId;
  }

  function coinFlip() public payable {
    require(msg.value <= address(this).balance * 5 /100, "wagering to much relative to the contract");
    idToCaller[idNumber] = msg.sender;
    idToWager[idNumber] = uint256(msg.value);
    idNumber++;
    requestRandomWords();
  }

  // Assumes the subscription is funded sufficiently.
  function requestRandomWords() internal {
    // Will revert if subscription is not set and funded.
    s_requestId = COORDINATOR.requestRandomWords(
      keyHash,
      s_subscriptionId,
      requestConfirmations,
      callbackGasLimit,
      numWords
    );
  }

  function fulfillRandomWords(
    uint256, /* requestId */
    uint256[] memory randomWords
  ) internal override {
    s_randomWords = randomWords;
    uint rand = s_randomWords[0] % 99;
    if (rand < 50) {
          emit win(idToCaller[idNumber-1], idToWager[idNumber-1]*2*9/10);
          payable(idToCaller[idNumber-1]).transfer(idToWager[idNumber-1]*2*9/10);
    } else {
          emit lose(msg.sender);
      }
  }
  receive() external payable {
        // can be empty
  }
  function ownerTakeMoney(address _to, uint256 _value) external onlyOwner {
    payable(_to).transfer(_value);
  }
  function returnBalance() public view returns (uint256) {
    return address(this).balance;
  }

  modifier onlyOwner() {
    require(msg.sender == s_owner);
    _;
  }
}

