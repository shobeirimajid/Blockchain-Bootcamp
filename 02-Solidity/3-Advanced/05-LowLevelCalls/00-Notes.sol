/*

    low-level calls:
        .transfer()
        .send()
        .call()
        .delegatecall()
        .staticcall()


    Features:
        - operate on "addresses" rather than "contract instances"
        - do not check the contract existence (by extcodesize opcode) 
        - cheaper in terms of gas
        - less safe!


        -------------------------------------------
        You can send Ether to other contracts by
        -------------------------------------------
        METHOD      GAS COST            IF FAIL
        -------------------------------------------
        transfer    2300 gas            throws error
        send        2300 gas            returns bool
        call        forward all gas     returns bool
        -------------------------------------------
            * gas limit for call is adjustable *
        -------------------------------------------


        send    is the "low-level" counterpart of the "transfer" function but
        if the execution "fails", the current contract will "not stop with an exception", but send will "return false"
        and failure handling is left to the calling contract.

        
        Both "send" and "transfer" can be used for payments to EOAs or other smart contracts. 
        But since the amount of gas they forward to the called smart contract is very low, 
        the called smart contract can easily run out of gas. This would make the payment impossible.


        The problem here is that even if the receiving contract is designed carefully not to exceed the gas limit, 
        future changes in the gas costs for some opcodes can break this design.
        Therefore, the recommended way of sending payments is :  call()


        call            Execute code of another contract



        delegatecall    Execute code of another contract, but with the state(storage) of the calling contract. 
                When a third contract calls a delegate call to some function in callee on behalf of the caller 
                and storage changes are made in the caller’s value and nothing is reflected in callee’s storage. 
                This means that a contract can dynamically load code from a different address at runtime. 
                Storage, current address, and balance still refer to the calling contract, 
                only the code is taken from the called address.

        

        staticcall      This is basically the same as a call, 
                    but will revert if the called function modifies the state in any way.

        

        How to receive Ether?

        A contract receiving Ether must have at least one of the functions below

        -----------------------------------------------------------
        METHOD                              WHEN CALL
        -----------------------------------------------------------
        receive() external payable          if msg.data is empty
        fallback() external payable         otherwise
        -----------------------------------------------------------


        "receive"
            Ether transfers
            empty calldata


        "fallback" function
            interface confusions (none of the other functions match the function identifier)
            non-empty calldata (even if Ether is sent along with the call)

        


        Which function is called, fallback() or receive()?


                     send Ether
                         |
                msg.data is empty?
                        / \
                       /   \
                    yes     no
                    /         \
           receive() exists?   fallback()
                /   \
              yes   no
            /         \
        receive()    fallback()


*/