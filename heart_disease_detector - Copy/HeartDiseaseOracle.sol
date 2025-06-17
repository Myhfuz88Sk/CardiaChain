// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19; // Specifies the Solidity compiler version

// Import necessary Chainlink Contracts libraries
import {FunctionsClient} from "@chainlink/contracts/src/v0.8/functions/v1_0_0/FunctionsClient.sol";
import {ConfirmedOwner} from "@chainlink/contracts/src/v0.8/shared/access/ConfirmedOwner.sol";
import {Strings} from "@openzeppelin/contracts/utils/Strings.sol"; // OpenZeppelin for string utilities

/**
 * @title HeartDiseaseOracle
 * @notice This contract receives heart disease prediction results and can use Chainlink Functions
 * to perform off-chain computations before storing the result on-chain.
 */
contract HeartDiseaseOracle is FunctionsClient, ConfirmedOwner {
    // Using Strings library for uint256 to string conversion (though not directly used in the final version, good practice for string manipulation)
    using Strings for uint256;

    // --- State Variables ---
    bytes32 public s_lastRequestId; // Stores the ID of the last Chainlink Functions request
    string public s_lastPredictionResult; // Stores the last processed prediction result from Chainlink Functions
    address public s_lastRequester; // Stores the address that initiated the last prediction request
    bool public s_predictionStored; // Flag to indicate if a prediction has been successfully stored on-chain

    // State variables specific to Chainlink Functions configuration
    bytes33 s_donId; // Data Operating Network (DON) ID for Chainlink Functions (e.g., Sepolia DON ID)
    uint64 s_subscriptionId; // Your Chainlink Functions subscription ID, funded with LINK
    uint32 s_callbackGasLimit; // Gas limit for the Chainlink Functions callback execution

    // --- Events ---
    event PredictionStored(address indexed requester, string result, bytes32 requestId); // Emitted when a prediction is successfully stored
    event RequestSent(bytes32 indexed requestId); // Emitted when a Chainlink Functions request is sent
    event RequestFulfilled(bytes32 indexed requestId, string result); // Emitted when a Chainlink Functions request is fulfilled

    // --- Constructor ---
    /**
     * @param router Chainlink Functions router address for the network
     * @param donId DON ID for the network
     * @param subscriptionId Your Chainlink Functions subscription ID
     */
    constructor(address router, bytes32 donId, uint64 subscriptionId)
        FunctionsClient(router) // Initializes the FunctionsClient base contract
        ConfirmedOwner(msg.sender) // Sets the deployer as the contract owner
    {
        s_donId = donId;
        s_subscriptionId = subscriptionId;
        s_callbackGasLimit = 300_000; // Default callback gas limit
    }

    // --- Functions ---

    /**
     * @notice Initiates a Chainlink Functions request to process a prediction result.
     * @param prediction The raw prediction string from your Python app (e.g., "Heart Disease Detected 💔")
     * @dev Only callable by the contract owner (from ConfirmedOwner).
     * @return requestId The ID of the Chainlink Functions request.
     */
    function requestPredictionProcessing(string calldata prediction) external onlyOwner returns (bytes32 requestId) {
        // Prepares the JavaScript source code and arguments for the Chainlink Functions request.
        // The JavaScript code defines the off-chain logic.
        // It then sends the request using the inherited _sendRequest function.
    }

    /**
     * @notice Callback function for Chainlink Functions.
     * This function is automatically called by the Chainlink Functions system once the
     * off-chain computation is complete.
     * @param requestId The ID of the request that was fulfilled.
     * @param response The raw bytes response from the Functions execution.
     * @param err The error message, if any, from the Functions execution.
     * @dev This function overrides the fulfillRequest from FunctionsClient.
     */
    function fulfillRequest(
        bytes32 requestId,
        bytes memory response,
        bytes memory err
    ) internal override {
        // Handles the response or error from the Chainlink Functions execution.
        // Decodes the response and stores it in s_lastPredictionResult.
        // Sets s_predictionStored to true on success.
        // Emits PredictionStored or RequestFulfilled events.
    }

    /**
     * @notice Returns the last stored prediction result.
     * @return string The last processed prediction result.
     */
    function getLastPredictionResult() public view returns (string memory) {
        // Returns the value of s_lastPredictionResult.
    }

    /**
     * @notice Returns whether a prediction has been stored.
     * @return bool True if a prediction has been stored, false otherwise.
     */
    function hasPredictionStored() public view returns (bool) {
        // Returns the value of s_predictionStored.
    }
}