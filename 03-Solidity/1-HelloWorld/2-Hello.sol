// SPDX-License-Identifier: MIT

pragma solidity >=0.4.0 <=0.9.0;

contract Hello {

    string public helloStr = "Initial Value";

    constructor() {
        helloStr = "Hello World!";
    }


    // عملکرد: مقدار جدیدی را در متغیر ذخیره میکند
    // برای نوشتن اطلاعات در بلاکچین باید هزینه پرداخت شود - Gas

    // Transaction in Web3:
    // Hello.setHello("Welcome");

    function setHello(string memory newValue) public {
        helloStr = newValue;
    }

    // getHello()
    function getHello() public view returns(string memory) {
        return helloStr;
    }
    
    function getHelloV2() public view returns(string memory returnValue) {
        returnValue = helloStr;
    }

    // getHello("Hello")
    function getHello(string memory val2) public pure returns(string memory) {
        string memory tempValue = val2;
        return tempValue;
    }

    // گرفتن خروجی فقط در توابع ویو و پیور امکانپذیر است
    function getHelloV4() public returns(string memory) {
        helloStr = "Welcome to Solidity";
        return helloStr;
    }


    // فانشکن میتواند بیش از یک مقدار را برگشت دهد
    function getHelloV5() public pure returns(string memory, string memory) {
        string memory memoryVar1 = "Welcome to";
        string memory memoryVar2 = "Solidity";
        return (memoryVar1, memoryVar2);
    }


    function getHelloV5(
        string memory memoryVar1, 
        string memory memoryVar2
    ) public pure returns(
        string memory, 
        string memory
    ) {
        return (memoryVar1, memoryVar2);
    }

}


/*
    EVM memory location:

        1- storage  ->              state variable - blockchain - gas
        2- memory   ->              {function input and output parameters} and {variable inside the function body}
        3- call_data/stack  ->      function call()
*/


/*
    memory:
        string
        struct
        array
        mapping
        bytes
*/



/*
    state mutability
        pure    :   به متغیرهای استیت اشاره ای نشده باشد
        view    :   متغیرهای استیت خوانده شده باشد
        payable :   وقتی که کانترکت ارز نیتیو دریافت میکند
*/



/*

[
	{
		"inputs": [],
		"name": "getHelloV4",
		"outputs": [
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "string",
				"name": "newValue",
				"type": "string"
			}
		],
		"name": "setHello",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"stateMutability": "nonpayable",
		"type": "constructor"
	},
	{
		"inputs": [],
		"name": "getHello",
		"outputs": [
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "string",
				"name": "val2",
				"type": "string"
			}
		],
		"name": "getHello",
		"outputs": [
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			}
		],
		"stateMutability": "pure",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getHelloV2",
		"outputs": [
			{
				"internalType": "string",
				"name": "returnValue",
				"type": "string"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getHelloV5",
		"outputs": [
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			}
		],
		"stateMutability": "pure",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "string",
				"name": "memoryVar1",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "memoryVar2",
				"type": "string"
			}
		],
		"name": "getHelloV5",
		"outputs": [
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			}
		],
		"stateMutability": "pure",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "helloStr",
		"outputs": [
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			}
		],
		"stateMutability": "view",
		"type": "function"
	}
]

*/