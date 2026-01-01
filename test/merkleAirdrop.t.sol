// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {MerkleProof} from "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";
import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import {Test,console} from "forge-std/Test.sol";
import { MerkleAirdrop} from "src/merkleAridrop.sol";
import {BagalToken} from "src/BagalToken.sol";
import {Test,console} from "forge-std/Test.sol";
contract MerKleAirdropTest is Test{
bytes32[] public PROOF = [0x0fd7c981d39bece61f7499702bf59b3114a90e66b51ba2c53abdf7b62986c00a,0xe5ebd1e1b5a5478a944ecab36a9a954ac3b6b8216875f6524caa7a1d87096576];

MerkleAirdrop public merkleAirdrop;
BagalToken public bagalToken;
bytes32 public Root = 0xaa5d581231e596618465a56aa0f5870ba6e20785fe436d5bfb82b08662ccc7c4;
address public user;
uint256 userKey;
    function setUp() public{
        bagalToken = new BagalToken();
        merkleAirdrop = new MerkleAirdrop(Root,bagalToken);
      (user,userKey) = makeAddrAndKey("user");
    //  bagalToken.mint(address(bagalToken), 100 ether);
   
   
    }



function testUseranlaim() external{
   uint256 startingBalance = bagalToken.balanceOf(user);

   vm.prank(user);
   
   
}

    
}