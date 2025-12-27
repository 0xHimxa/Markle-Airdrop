// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";



contract MakleAirdrop{

    bytes32 private immutable  i_markleRoot;
    IERC20 private immutable airdropToken;



    constructor(bytes32 markleRoot, IERC20 token){
        i_markleRoot = markleRoot;
        airdropToken = token;
    


    }


    function claim(address account,uint256 amount,bytes32[] calldata markleProof) external{

//hashe the proof twise to avoid colition
        bytes32  leaf = keccak256(bytes.concat(keccak256(abi.encode(account,amount))));

    }


}