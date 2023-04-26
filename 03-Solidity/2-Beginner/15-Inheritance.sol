// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

// Base - Parent
//import "./A.sol"
contract A {

    // فانکشنی که به صورت ویرچوال باشد را می توان در کانترکت فرزند به شکل متفاوتی بازنویسی کرد
    // وقتی کلمه ویرچوال را برداریم دیگر بعد از این هیچ کانترکتی نمی تواند پس از مشتق شدن، این تابع را بازنویسی کند
    function add(uint a, uint b) public pure virtual returns(uint) {
        return a+b;
    }

    // در یک کانترکت شما میتوانید یک تابع با اسم یکسان را با چندین امضای متفاوت داشته باشید
    function add(uint a, uint b, uint c) public pure virtual returns(uint) {
        return a+b+c;
    }
}


// Drived - Child - Inherited
/* کانترکت فرزند متغیرها و توابعی از کانترکت والد را به ارث می برد که شرایط زیر را داشته باشند
    
        Variables:  public, internal
        Functions:  public, internal, external
    
    متغیرها و فانکشن های پرایوت فقط برای خود کانترکت قابل مشاهده هستند
*/

contract B is A {
   
    // تا وقتی که تابع جمع را اورراید نکرده باشیم، این تابع از کلاس والد خوانده می شود
    // ولی به محض افزودن نسخه اورراید شده، از تابع جمع این کانترکت استفاده خواهد شد
    uint public result1 = add(2,3);


    function add(uint a, uint b) public pure virtual override returns(uint) {

        uint c = a+b;

        if(c<a)
            return 0;   // overflow
        else
            return c;
    }


    function add(uint a, uint b, uint c) public pure virtual override returns(uint) {
        uint d = a+b+c;
        if(c<a)
            return 0;
        else
            return d;
    }


    // تا وقتی که تابع جمع را اورراید نکرده باشیم، این تابع از کلاس پدر خوانده می شود
    // ولی به محض افزودن نسخه اورراید شده، از تابع جمع این کانترکت استفاده خواهد شد
    uint public result2 = add(1,2,3);

    uint public result3 = super.add(2,3);   // A.add(2,3);

    function addOfA(uint a, uint b) public pure returns(uint) {
        return super.add(a,b);  // A.add(a,b);
    }
}


// A -> B -> C    =>    A -> C
contract C is B {
    uint public result4 = super.add(2,3);       // B.add(2,3);
    uint public result5 = super.addOfA(2,3);    // A.add(2,3);
}


// Multiple Inheritance
// https://docs.soliditylang.org/en/v0.8.15/contracts.html#multiple-inheritance-and-linearization
contract D is B,C {

}