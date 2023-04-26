// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

contract GlobalVariables {


    // اطلاعات مربوط به آخرین بلاک ماین شده شبکه
    function getBlockInfo() public view returns(uint, uint, uint, address payable, uint, bytes32) {

        return (
            block.number,               // شماره آخرین بلاک ماین شده در شبکه
            block.timestamp,            // تایم ماین شدن آخرین بلاک شبکه
            block.difficulty,           // میزان سختی ماین شدن آخرین بلاک شبکه 
            block.coinbase,             // آدرس ماینر بلاک
            block.chainid,              // شناسه زنجیره ای که بلاک در آن ماین و درج شده
            blockhash(block.number)     // هش بلاک
            );
    }


    // اطلاعات گس
    function getGasInfo() public view returns(uint, uint, uint) {

        uint remainedGas = gasleft();       //  gasleft ~ remainedGas =  (GasLimit - GasUsed)

        uint gasLimit = block.gaslimit;     // محدودیت گس بلاک

        uint basefee = block.basefee;       // قیمت پایه هر گس در بلاک

        return ( gasLimit, basefee, remainedGas);
    }


    // اطلاعات فانکشن
    function getMsgInfo() public payable returns(address, uint, bytes calldata, bytes4) {

        address caller =                msg.sender;         // آدرس اکانتی که این فانکشن را فراخوانی کرده
        uint sentValue =                msg.value;          // مبلغی که فراخوانی کننده تابع، به کانترکت پرداخت کرده
        bytes calldata functionData =   msg.data;           // دیتای فانکشن در فضای کال_دیتا/استک
        bytes4 functionID =             msg.sig;            // شناسه یا امضای فانکشن          

        /*
            msg.sig is The first four bytes of the calldata/stack for a function 
                that specifies the function to be called
                i.e., it’s function identifier
        */

        return (caller, sentValue, functionData, functionID);
    }



    // اطلاعات کانترکت
    function getContractInfo() public view returns(address, uint) {

        address contractAddress = address(this);            // آدرس اسمارت کانترک جاری

        uint contractBalance = contractAddress.balance;     // موجودی اسمارت کانترکت

        return (contractAddress, contractBalance);
    }


    function encode(uint8 num) public pure returns (bytes memory) {

        /*
            decimal/base10   :    0,1,2,3,4,5,6,7,8,9
            binary/base2     :    0,1
            Hex/base16       :    0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F

            // مثال از معادل هگز اعداد دسیمال
                16 = 1*16 + 0  :  10 ~ 0a
                17 = 1*16 + 1  :  11 ~ 0b
                32 = 2*16 + 0 :   20
                33 = 2*16 + 1 :   21
                50 = 3*16 + 2 :   32

            مثال : عدد 2 در فرم هگز انکود شده
            0x
            02 
            ----
            0x02
        */

        return abi.encodePacked(num);
    }


    function encode(uint8 num1, uint8 num2) public pure returns (bytes memory) {

        /*
            0x<num1><num2>
            // مثال:
            num1 = 16 ~ 10 = a = 0a
            num2 = 50 ~ 32
                => 0x0a32
        */

        return abi.encodePacked(num1, num2);
    }



    // مقایسه دو استرینگ در سالیدیتی
    function compareStr(string memory s1, string memory s2) public pure returns (bool) {

        // دو دیتا که هش آنها یکسان باشد، با هم برابرند
        return ( keccak256(abi.encodePacked(s1)) == keccak256(abi.encodePacked(s2)) );   // condition -> true/false
    }



    function getHash(bytes memory input) public pure returns(bytes32) {

        /*
            input: 0x0102
            hash:  0x22ae6da6b482f9b1b19b0b897c3fd43884180a1c5ee361e1107a1bc635649dda
        */

        // یکی از کاربردهای هش برای بررسی صحت و جامعیت دیتا است
        return keccak256(input);
    }


        /*
            type casting - تبدیل نوع

                address(this)  
                address(0)
                payable(address)
                uint(bytes)
        */


    function getRandom(uint max) public view returns(uint) {
        uint rand = uint ( keccak256( abi.encodePacked(block.difficulty, block.timestamp) ) );
        return rand % max;
    }


    // pitfall
    function getBatchRandom() public view returns(uint[10] memory rnds) {

        for(uint i=0; i<10; i++) {
            rnds[i] = getRandom(100);
        }
    }

    /*
        بهترین راهکار برای تولید اعداد تصادفی استفاده از اوراکل ها است
        یکی از بهترین ها
        chainLink - link
    */

}