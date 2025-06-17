# CardiaChain
Heart disease prediction with blockchain

💓 HeartBeatLink: Decentralized Heart Disease Prediction
This project demonstrates a hybrid approach to heart disease prediction, integrating off-chain AI with Chainlink Functions for verifiable on-chain data recording.

Project Overview
Off-chain ML: A Flask app predicts heart disease using a Random Forest Classifier.
On-chain Recording: Prediction results are sent to a Solidity smart contract which uses Chainlink Functions to securely process and record them as a state change on the blockchain.
This project meets the Chainlink hackathon requirement by utilizing Chainlink Functions to perform a state change on-chain based on a Chainlink interaction.

Key Files & Chainlink Integration
The core Chainlink integration is found in these files:

app.py:

Initiates the Chainlink Functions request by calling the requestPredictionProcessing function on the smart contract after an ML prediction.
Link to app.py (Specific lines for Web3/Chainlink interaction will be highlighted in your full repo)
contracts/HeartDiseaseOracle.sol:

The Solidity smart contract that implements Chainlink Functions.
Receives prediction data, triggers the off-chain computation via Chainlink Functions, and updates its on-chain state (s_lastPredictionResult) with the verified result.
Link to contracts/HeartDiseaseOracle.sol (Assuming your contract is here)
abi/HeartDiseaseOracle.json:

Contains the ABI for HeartDiseaseOracle.sol, enabling web3.py to interact with it.
Link to abi/HeartDiseaseOracle.json (Assuming your ABI is here)
Stack
Frontend: HTML, CSS, JS
Backend: Python (Flask, Scikit-learn, web3.py)
Blockchain: Solidity, Hardhat/Foundry, Ethereum-compatible Testnet, Chainlink Functions

+----------------+      +------------------+      +------------------------+      +---------------------+
| User Interface |----->| Flask Backend    |----->| Python ML Model        |----->| Heart Disease Pred. |
| (index.html)   |      | (app.py)         |      | (RandomForestClassifier)|      | (result_text)       |
+----------------+      +------------------+      +------------------------+      +---------------------+
                                  |
                                  | (Call contract function 'requestPredictionProcessing')
                                  V
                           +------------------------+
                           | Web3.py Interaction    |
                           | (Sends TX to Blockchain)|
                           +------------------------+
                                  |
                                  | (Transaction on Blockchain)
                                  V
                          +-------------------------+
                          | HeartDiseaseOracle.sol  |<--------------------+
                          | (Deployed Smart Contract)|                     |
                          |   - Calls Chainlink Functions                  |
                          +-------------------------+                     |
                                  |                                       |
                                  | (Chainlink Functions Request)         |
                                  V                                       |
                          +-------------------------+                     |
                          | Chainlink Functions DON |                     |
                          | (Decentralized Oracle   |                     |
                          |  Network - Executes JS) |                     |
                          +-------------------------+                     |
                                  |                                       |
                                  | (Processed Result/Error)              |
                                  V                                       |
                          +-------------------------+                     |
                          | Chainlink Callback      |                     |
                          | (fulfillRequest in SC)  |---------------------+
                          |   - Updates On-Chain State                     |
                          +-------------------------+
