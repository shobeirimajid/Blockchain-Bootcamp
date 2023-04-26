// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.18;

import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./3-MyToken.sol";

contract TokenSender {
    
    using ECDSA for bytes32;

    mapping(bytes32 => bool) executed;

    // Helper function to calculate the keccak256 hash
    function getHash(
        address from,
        uint amount,
        address to,
        address token,
        uint nonce
    ) public pure returns (bytes32 hash) {
        hash = keccak256(abi.encodePacked(
            from,
            amount,
            to,
            token,
            nonce
        ));
    }

    function transfer(
        address from,
        uint amount,
        address to,
        address token,
        uint nonce,
        bytes memory signature
    ) public {

        // Calculate the hash of all the requisite values
        bytes32 hash = getHash(from, amount, to, token, nonce);

        // Convert it to a signed message hash
        bytes32 ethSignedHash = hash.toEthSignedMessageHash();

        // Require that this signature hasn't already been executed
        require(!executed[ethSignedHash], "Already executed!");

        // Make sure signer is the person on whose behalf we're executing the transaction
        require(ethSignedHash.recover(signature) == from, "Signature does not come from sender");

        // Mark this signature as having been executed now
        executed[ethSignedHash] = true;

        // Transfer tokens from sender(signer) to recipient
        bool success = IERC20(token).transferFrom(from, to, amount);
        require(success, "Transfer Failed");
    }
}

/*
    -------------------------------------------------------
      from:   0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
      amount: 1000000000000000000000
      to:     0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
      token:  0xf8e81D47203A594245E36C48e151709F0C19fBe8
      1
    -------------------------------------------------------
      hash        0x03d9ff393b5f9be8486d4aa2f20cf86d5084b2c23bb150a8802fcc297fe82e61
    -------------------------------------------------------
      signature   0x0dde130b76b28eecdb305b28db178764d0776591ee3e2866891d3d8f7c6872075b91c6638a1114979973e04a971bbe3b9914662a479b7fadf78f2979e34d54761b
    -------------------------------------------------------
*/