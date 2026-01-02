// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {MerkleAirdrop} from "src/merkleAridrop.sol";
import {BagalToken} from "src/BagalToken.sol";
import {Script, console} from "forge-std/Script.sol";

contract DeployMerKleAirdropTest is Script {
    bytes32 private s_merkleRoot = 0xaa5d581231e596618465a56aa0f5870ba6e20785fe436d5bfb82b08662ccc7c4;
    uint256 private contract_amount = 1000e18;

    function deployMerkleAirdrops() public returns (MerkleAirdrop merkleAirdrop, BagalToken token) {
      //  vm.startBroadcast();
        token = new BagalToken();
        merkleAirdrop = new MerkleAirdrop(s_merkleRoot, token);

        token.mint(address(merkleAirdrop), contract_amount);
       // vm.stopBroadcast();
    }

    function run() external {
        vm.startBroadcast();
        deployMerkleAirdrops();
        vm.stopBroadcast();
    }
}
