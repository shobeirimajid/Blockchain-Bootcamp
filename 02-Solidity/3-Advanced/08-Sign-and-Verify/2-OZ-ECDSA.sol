// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.18;

import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import "@openzeppelin/contracts/utils/cryptography/SignatureChecker.sol";

contract VerifySignatureOZ {

    function getMessageHash(string memory _msg) public pure returns (bytes32 hash) {
        hash = keccak256(abi.encodePacked(_msg));
    }

    // Verify that the message was signed by the (private keys of) claimedSigner

    using ECDSA for bytes32;
    
    function ECDSAVerify(bytes32 hash, address claimedSigner, bytes memory signature) public pure returns (bool) {
        return hash.toEthSignedMessageHash().recover(signature) == claimedSigner;
    }

    using SignatureChecker for address;

    function ECDSAVerifyV2(bytes32 hash, address claimedSigner, bytes memory signature) public view returns (bool) {
        return claimedSigner.isValidSignatureNow(hash.toEthSignedMessageHash(), signature);
    }
}