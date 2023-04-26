// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

contract SimpleToken {

    // موجودی اولیه توکن
    uint private initialSupply;

    uint private total_Supply;

    // آدرس مالک توکن/آدرس اکانتی که توکن را دپلوی میکند
    address private owner;

    // نام کامل توکن
    string public name;

    // نام اختصاری یا سیمبول توکن
    string public symbol;

    // دسیمال توکن
    uint8 public decimals;

    // تعداد توکن موجودی هر اکانت
    mapping(address => uint) public balances;

    // مقداد توکن مجاز برای برداشت از حساب دارنده توکن
    mapping(address => mapping(address => uint)) public allowances;

    // transfer() , transferFrom() , mint( _from : address(0) ) , burn( _to : address(0) )
    event Transfer(address indexed _from, address indexed _to, uint indexed _amount);

    // approve()
    event Approval(address indexed _owner, address indexed _spender, uint indexed _amount);


    constructor(
        uint _initialSupply, 
        string memory _name, 
        string memory _symbol, 
        uint8 _decimals
    ) {

        owner = msg.sender;

        initialSupply = _initialSupply;
        decimals = _decimals;    

        name = _name;
        symbol = _symbol;

        mint(initialSupply * 10**decimals);    // mint
    }


    function mint(uint amount) public {

        require(msg.sender == owner, "only owner can mint!");

        balances[owner] += amount;
        total_Supply += amount;

        emit Transfer(address(0), owner, amount);
    }

    // این تابع توسط کسی فراخوانی میشود که قصد دارد تعدادی از توکن های خود را به آدرس دیگری انتقال دهد
    // msg.sender ~ Holder Of Token
    function transfer(address _to, uint _amount) public returns(bool) {

         // چک کردن موجودی توکن
        require(balances[msg.sender] >= _amount, "Transfer: Not enough balance!");       

        // انتقال توکن - بروزرسانی موجودی ها
        balances[msg.sender] -= _amount;     // برداشت
        balances[_to] += _amount;            // واریز

        emit Transfer(msg.sender, _to, _amount);

        return true;
    }


    // دارنده توکن با فراخوانی این تابع به یک اکانت دیگر اجازه برداشت به مقدار معین را صادر میکند
    // msg.sender ~ holder
    function approve(address _spender, uint _amount) public returns(bool) {

        // بروزرسانی اجازه برداشت
        allowances[msg.sender][_spender] = _amount;

        // رویداد اجازه برداشت
        emit Approval(msg.sender, _spender, _amount);

        return true;
    }


    // این تابع توسط یک شخص ثالث فراخوانی شده و به تعدادی که مجاز است، توکن از حساب مالک به حساب مقصد انتقال میدهد
    // msg.sender ~ spender
    function transferFrom(address _from, address _to, uint _amount) public returns(bool) {

        // چک کردن اجازه برداشت باقیمانده فراخوانی کننده از حساب مبدا
        uint _allowance = allowances[_from][msg.sender];
        require(_allowance >= _amount, "transferFrom: insufficient allowance!");

        // چک کردن موجودی توکن
        require(balances[_from] >= _amount, "transferFrom: Not enough balance!");

        // انتقال توکن - بروزرسانی موجودی ها
        balances[_from] -= _amount;    // برداشت
        balances[_to] += _amount;      // واریز

        // بروزرسانی اجازه برداشت
        allowances[_from][msg.sender] -= _amount;

        emit Transfer(msg.sender, _to, _amount);

        return true;
    }


    function balanceOf(address _account) public view returns(uint) {
        return balances[_account];
    }

    function allowance(address _holder, address _spender) public view returns(uint) {
        return allowances[_holder][_spender];
    }

    function totalSupply() public view returns(uint) {
        return total_Supply;
    }
}


/*
    Acc1 : 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4 : owner
    Acc2 : 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2 : receiver
    Acc3 : 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db : spender

    initialSupply = 3000

    owner: Acc1 : 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
    balance: 3000

    name: My Token
    symbol: MTK
    decimals: 18

    msg.sender: Acc1
    transfer(Acc1 => Acc2, 1000)

    msg.sender: Acc1
    approve(Acc3, 500)

    msg.sender: Acc3
    transferFrom(Acc1 => Acc2, 200)
    transferFrom(Acc1 => Acc2, 300)
*/