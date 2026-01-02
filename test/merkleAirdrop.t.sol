// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import {Test, console} from "forge-std/Test.sol";
import {MerkleAirdrop} from "src/merkleAridrop.sol";
import {BagalToken} from "src/BagalToken.sol";
import {Test, console} from "forge-std/Test.sol";
import {DeployMerKleAirdropTest} from "script/DeployMerkleAdrop.s.sol";

contract MerKleAirdropTest is Test {
    bytes32[] public PROOF;
    MerkleAirdrop public merkleAirdrop;
    BagalToken public bagalToken;
    bytes32 public Root = 0xaa5d581231e596618465a56aa0f5870ba6e20785fe436d5bfb82b08662ccc7c4;
    address public user;
    uint256 userKey;
    address gasPayer;
    uint256 AMOUNT = 25 * 1e18;

    function setUp() public {
        DeployMerKleAirdropTest deployerMerkle = new DeployMerKleAirdropTest();
        PROOF = new bytes32[](2);
        PROOF[0] = 0x0fd7c981d39bece61f7499702bf59b3114a90e66b51ba2c53abdf7b62986c00a;
        PROOF[1] = 0xe5ebd1e1b5a5478a944ecab36a9a954ac3b6b8216875f6524caa7a1d87096576;
        (merkleAirdrop, bagalToken) = deployerMerkle.deployMerkleAirdrops();
        (user, userKey) = makeAddrAndKey("user");
        gasPayer = makeAddr("gasPayer");
    }

    function testUseranlaim() external {
        uint256 startingBalance = bagalToken.balanceOf(user);
        bytes32 digest = merkleAirdrop.getMessageHash(user, AMOUNT);

        console.log(startingBalance, "User Starting Balance");
     
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(userKey, digest);

        vm.prank(gasPayer);
        merkleAirdrop.claim(user, AMOUNT, PROOF, v, r, s);

        uint256 endingBalance = bagalToken.balanceOf(user);
        console.log(endingBalance, "User Ending Balance");
        assertEq(endingBalance - startingBalance, AMOUNT);
    }
}
