import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {MerkleAirdrop} from "src/merkleAridrop.sol";
import {BagalToken} from "src/BagalToken.sol";
import {Script, console} from "forge-std/Script.sol";


contract ClaimAirdrop is Script {
   address claiming_Address = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266;
    bytes32 proof1 =  0xd1445c931158119b00449ffcac3c947d028c0c359c34a6646d95962b3b55c6ad;
    bytes32 proof2 =  0xe5ebd1e1b5a5478a944ecab36a9a954ac3b6b8216875f6524caa7a1d87096576;
    bytes32[] merkleProof = [proof1,proof2];


error ClaimAirdrop__InvalidSignature();


    //this signature i been gotten when we deployed our contract and interact with the getmessageHash, it resturn a bytes
    // which we now use 
    // cast wallet sign --no-hash what the getmesshasd returned;
bytes32 private SIGNATURE = hex"0x12e145324b60cd4d302bfad59f72946d45ffad8b9fd608e672fd7f02029de7c438cfa0b8251ea803f361522da811406d441df04ee99c3dc7d65f8550e12be2ca1c";
//now we will need to splid the sig to get the vrs, caused it been combined, it was base on how we impled the contact, check how u hash func

(uint8 v,bytes32 r, bytes32 s) = splitSignature(SIGNATURE);



function run() external{
    address mostRecentDeployed = DevOpsTools.get_most_recently_deployment("MerkleAirdrop",block.chainid);
  claimAirdrop(mostRecentDeployed);



}


function  claimAirdrop(address airdrop) public{
 
    
    vm.startBroadcast();
 MerkleAirdrop(airdrop).claim(account, amount, merkleProof, v, r, s);   
 vm.stopBroadcast();

}



function  splitSignature(bytes memory sig) public returns(uint8 v,bytes32 r, bytes32 s){

if(sig.length != 65){
    revert ClaimAirdrop__InvalidSignature();
}



assembly{
r:=mload(add(sig,32))
s:=mload(add(sig,64))
v:=mload(add(sig,96))
}

}

} 