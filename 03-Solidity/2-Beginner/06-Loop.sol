// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

contract Loop {


    uint8[] ary = [1,2,3,4,5];


    function addAryElements() public view returns(uint) {

        uint sum;

        for(uint i=0; i<ary.length; i++) {          // i++   ~   i = i + 1   ~   i += 1
            sum += ary[i];   // sum = sum + ary[i];
        }

        return sum;
    }


    function addAryElementsV2() public view returns(uint) {

        uint sum;

        uint i=0;
        while(i<ary.length) {
            sum += ary[i];
            i++;
        }

        return sum;
    }


    // در آرایه دنبال عدد ورودی می گردد و ایندکس خانه مورد نظر از آرای را برمیگرداند
    function breakLoop(uint8 num) public view returns(uint) {

        uint index;

        for(uint i=0; i<ary.length; i++) {

            if(ary[i] == num) {
                index = i;
                break;  // کلا از حلقه تکرار بیرون می آید
            }
        }

        return index;
    }


    // اندیس های فرد را نادیده گرفته و فقط اندیس های زوج جمع میگردد
    // sum = 1 + 3 + 5 = 9
    function continueLoop() public view returns (uint) {

        uint sum;

        for(uint i=0; i<ary.length; i++) {

            if(i%2 != 0) {      // عددی که باقیمانده تقسیم آن بر 2 عدد صفر باشد زوج است
                
                continue;       // بقیه دستورات داخل حلقه را اجرا نکرده و به ابتدای حلقه می رود
            }

            sum += ary[i]; 
        }

        return sum;
    }

}



    /*
            ساختارهای تکرار
        برای اجرای تکراری یک قطعه کد یا حتی فانکشن
            - for
            - while

        دستورات شکست / مدیریت اجرای حلقه
            - break
            - continue
    */


    /*
        ساختار حلقه for

        for(index; condition; step) {
            // دستورات داخل حلقه تکرار
        }


        ساختار حلقه while

        while(condition) {
            // دستورات داخل حلقه تکرار
        }
    */

        

    /*

        uint8[] ary = [1,2,3,4,5];


        ----------------------------------
        sum = 0   count = 5
        ----------------------------------
        i=0      sum:0 + 1  -> sum:1
        i=1      sum:1 + 2  -> sum:3
        i=2      sum:3 + 3  -> sum:6
        i=3      sum:6 + 4  -> sum:10
        i=4      sum:10 + 5 -> sum:15


        uint sum;

        for(uint i = 0; i<ary.length; i++) {          // i++   ~   i = i + 1   ~   i += 1
            sum = sum + ary[i];
        }
        // sum = 15


        i++   :   i = i+1   -  ابتدا اندیس حلقه استفاده می شود و برای دور بعدی افزایش می یابد
        ++i   :   i = i+1   -  ابتدا اندیس حلقه افزایش می یابد
    */




