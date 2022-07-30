
pragma solidity ^0.8.0;
import "./Ownable.sol";
import "./Ownable.sol";

// soRandom protocol interface
interface ISoRandom {
    function requestRandom(uint24 _callbackGasLimit) external returns (uint256);

    function clientWithdrawTo(address _to, uint256 _amount) external;
}

// Proxy interface (retrieves the latest contract address)
interface ISRProxy {
    function soRandom() external view returns (address);
    function oldSoRandom() external view returns (address);
}

contract CoinFlip is Ownable {
    ISRProxy proxy = ISRProxy(0x608366E87b71C070332cC826Fe1615Bf41f3A224);

	// Stores each game to the player
    mapping(uint256 => address) public flipToAddress;

    // Events
    event Win(address winner);
    event Lose(address loser);

    // The coin flip containing the random request
    function flip() external returns (uint256) {
        // Get the latest soRandom contract from the testnet proxy
        address soRandom = proxy.soRandom();
        // Request a random number from the soRandom contract (50k callback limit)
        uint256 id = ISoRandom(soRandom).requestRandom(50000);
        // Store the flip ID and the player address
        flipToAddress[id] = msg.sender;
        // Return the flip ID
        return id;
    }

    // Callback function called by the soRandom contract when the random value is generated
    function soRandomCallback(uint256 _id, bytes32 _value) external {
		//Callback can only be called by soRandom
		require(msg.sender == proxy.soRandom() || msg.sender == proxy.oldSoRandom(), "CALLER_NOT_SORANDOM");
        // Get the player address from the flip ID
        address player = flipToAddress[_id];
        // Convert the random bytes to a number between 0 and 99
        uint256 random = uint256(_value) % 99;
        // If the random number is less than 50, the player wins
        if (random < 50) {
            emit Win(player);
        } else {
            emit Lose(player);
        }
    }

    // Allows the proxy to withdraw funds to deposit to a new contract when an alpha update is released
    function proxyWithdraw(address _soRandom, uint256 _amount) external {
        require(msg.sender == address(proxy), "CALLER_NOT_PROXY");
        ISoRandom(_soRandom).clientWithdrawTo(msg.sender, _amount);
    }

    // Allows the owner to withdraw their deposited soRandom funds
    function soRandomWithdraw(address _soRandom, uint256 amount)
        external
        onlyOwner
    {
        ISoRandom(_soRandom).clientWithdrawTo(msg.sender, amount);
    }
}