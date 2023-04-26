// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.18;

contract VerifySignature {

    function getMessageHash(string memory _msg) public pure returns (bytes32 hash) {
        hash = keccak256(abi.encodePacked(_msg));
    }

    // Signature is produced by signing a keccak256 hash with the following format: 
    // "\x19Ethereum Signed Message\n" + len(msg) + msg
    // Signature will be different for different accounts
    function getEthSignedHash(bytes32 hash) public pure returns (bytes32 ethSignedHash) {
        ethSignedHash = keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", hash));
    }

    function verify(address _claimedSigner, string memory _msg, bytes memory signature) public pure returns(bool) {
        bytes32 msgHash = getMessageHash(_msg);
        bytes32 ethSignedHash = getEthSignedHash(msgHash);
        return recoverSigner(ethSignedHash, signature) == _claimedSigner;
    }

    // recognize real recovered Signer
    function recoverSigner(
        bytes32 _ethSignedHash, 
        bytes memory _signature
    ) public pure returns (address recoveredSigner) {

        // ECDSA

        // 65 bytes
        // r: first 32 bytes, after the length prefix
        // s: second 32 bytes
        // v: final byte (first byte of the next 32 bytes)
        (bytes32 r, bytes32 s, uint8 v) = splitSignature(_signature);

        recoveredSigner = ecrecover(_ethSignedHash, v, r, s);
    }


    function splitSignature(bytes memory sig) public pure returns (bytes32 r, bytes32 s, uint8 v) {

        require(sig.length == 65, "invalid signature length");

        assembly {

            // add(sig, 32) = <pointer of sig> + 32 - effectively, skips first 32 bytes of signature
            // mload(p) loads next 32 bytes starting at the memory address p into memory

            // first 32 bytes, after the length prefix
            // stores the length of the signature
            r := mload(add(sig, 32))

            // second 32 bytes
            s := mload(add(sig, 64))

            // final byte (first byte of the next 32 bytes)
            v := byte(0, mload(add(sig, 96)))
        }

        // r: 0x44c61e3587f919da6ef3113e28c1c2d03d706c51763e03259b5f5da9741b491a
        // s: 0x06b3df565bef27e38a2e16bad9ab51e9106934b731f0d84d6ccce421f9e9d813
        // v: 27
    }

}


/* 
    ------------------------------------------
    How to Signature-Verification
    ------------------------------------------
    1. Signing (Off-chain)
        1. Create message to sign
        2. Hash the message
        3. Sign the hash (off chain, keep your private key secret)

    2. Verify (on-chain)
        1. Recreate hash from the original message
        2. Recover signer from signature and hash
        3. Compare "recovered signer" to "claimed signer"
*/



/*
    https://sepolia.etherscan.io/address/0x12e4a078a6f639ae2934c84b8c34ef45ef18cb61#code


    -------------------------
    1. getMessageHash()
    -------------------------
    _message: 'Hello world'    

    ===> hash: "0xed6c11b0b5b808960df26f5bfc471d04c1995b0ffd2055925ad1be28d6baadfd"


    -------------------------
    2. Signing the Hash
    -------------------------
    ethereum.enable()
    account = "0x041e61175A7822ac35611BE9F01Cd3bd53F8dF4f"
    hash = "0xed6c11b0b5b808960df26f5bfc471d04c1995b0ffd2055925ad1be28d6baadfd"

    [Sign with browser]
    ethereum.request({ method: "personal_sign", params: [account, hash]}).then(console.log)
    
    [Sign with Remix]
    web3.eth.sign(hash, account)
    
    [Sign with web3]
    web3.personal.sign(hash, web3.eth.defaultAccount, console.log)
    
    ===> signature = 0x8a7d38e4aba8f36e6c017dc7cde93e51ccae2c811eebf5460fa03093eb15d4ad6d7f2936b0739ae879c49fca85e3510ae138d73b414961beaa59e4b61d0970ec1c


    ------------------------------
    3. getEthSignedMessageHash()
    ------------------------------
    MessageHash: 0xed6c11b0b5b808960df26f5bfc471d04c1995b0ffd2055925ad1be28d6baadfd

    ===> EthSignedHash: 0xce93986fcf58607c7ebb1055297d4123bf5dd4599fd9a3e5fa16c8224958b356


    -------------------------
    4. Verify()
    -------------------------
    signer = 0x041e61175a7822ac35611be9f01cd3bd53f8df4f
    message = 'Hello world'
    signature: 0x44c61e3587f919da6ef3113e28c1c2d03d706c51763e03259b5f5da9741b491a06b3df565bef27e38a2e16bad9ab51e9106934b731f0d84d6ccce421f9e9d8131b

    MessageHash: 0x33de718b51ac90b967b443b77c43e3ab5edead83e1b7f182bdab6796d9678c15
    EthSignedHash: 0x5ea82569f4f10c4c202bbabf2ef1c4d64e736029414853d080bce2b52d6ad639

    ===> true
*/