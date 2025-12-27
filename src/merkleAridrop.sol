// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {MerkleProof} from "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";
import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";


contract MerkleAirdrop{


error  MerkleAirdrop__InvalidProof();

event Claim(address indexed user, uint256 amount);





    bytes32 private immutable  i_merkleRoot;
    IERC20 private immutable i_airdropToken;


using SafeERC20 for IERC20;



    constructor(bytes32 merkleRoot, IERC20 token){
        i_merkleRoot = merkleRoot;
        i_airdropToken = token;
    


    }


    function claim(address account,uint256 amount,bytes32[] calldata merkleProof) external{

//hashe the proof twise to avoid colition
        bytes32  leaf = keccak256(bytes.concat(keccak256(abi.encode(account,amount))));

if(!MerkleProof.verify(merkleProof, i_merkleRoot, leaf)){
    revert MerkleAirdrop__InvalidProof();
}


emit Claim(account, amount);
i_airdropToken.safeTransfer(account, amount);





    }


}