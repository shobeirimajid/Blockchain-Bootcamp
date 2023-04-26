/*
    Signature Verification

    ------------------------------------------
    Checking Signatures On-Chain
    ------------------------------------------
    ECDSA : Elliptic Curve Digital Signature Algorithm

    "ECDSA" provides functions for recovering and managing Ethereum account "ECDSA signatures"
        
    "ECDSA signatures" are often generated via :
        
    web3.eth.sign    →      65 byte array ("bytes" in Solidity) 
                            [ r : 32 bytes | s : 32 bytes | v : 1 bytes ]


    ------------------------------------------
    Why would I need this?
    ------------------------------------------
    We've actually discussed several examples of how one would use this before:

        1. Meta Transactions
        2. ERC20-Permit


    ------------------------------------------
    How to Signature-Verification
    ------------------------------------------
    1. Signing (Off-chain)
        1.1. Create message to sign
        1.2. Hash the message
        1.3. Sign the hash (off chain, keep your private key secret)

    2. Verify (on-chain)
        2.1. Recreate hash from the original message
        2.2. Recover signer from signature and hash
        2.3. Compare "recovered signer" to "claimed signer"
*/