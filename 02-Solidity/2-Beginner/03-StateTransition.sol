// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

contract StateTransition {


    uint startTime;
    uint currentTime;


    enum State {
        Reg,    // 0
        Vote,   // 1
        Count   // 2
    }
    State state;

    /*
        // assinment
        state = State.Vote;

        // check
        if(state == State.Vote)
            Vote();
    */


    constructor() {

    }


    // فرآیند کانترت از لحظه فراخوانی این فانکشن شروع خواهد شد
    function start() public {
        startTime = block.timestamp;
        currentTime = block.timestamp;
        state = State.Reg;
    }


    // بروزرسانی استیت کانترکت
    function updateState() public {
        // بروزرسانی تایم کنونی
        currentTime = block.timestamp;

        if(currentTime <= (startTime + 10 seconds))             // ده ثانیه اول
            state = State.Reg;

        else if(currentTime <= (startTime + 20 seconds))        // ده ثانیه دوم
            state = State.Vote;
        
        else                                                    // ده ثانیه سوم به بعد
            state = State.Count;
    }


    function getState() public view returns (string memory) {

        // return state;   // 0,1,2

        string memory stateStr;

        if(state == State.Reg)
            stateStr = "Reg";
        else if(state == State.Vote)
            stateStr = "Vote";
        else 
            stateStr = "Count";

        return stateStr; // "Reg",  "Vote", "Count"
    }


    function getStartTime() public view returns (uint) {
        return startTime;
    }


    function getCurrentTime() public view returns (uint) {
        return block.timestamp;
    }


    function getLastUpdateTime() public view returns (uint) {
        return currentTime;
    }
}


/*
    یک کانترکت میتواند مراحل یا فازهای مختلفی داشته باشد
    ممکن است برخی توابع را بخواهیم فقط در فاز مشخصی قابل اجرا باشد

    مثال
        کانترکت رای گیری
            Register
            Vote
            Count

        uint state;
        state = 0;        // Register
        state = 1;        // Vote
        state = 2;        // Count

        if(state == 1)
            vote();


        کانترکت عرضه اولیه توکن

        کانترکت مزایده آنلاین
    
*/



/*
    واحدهای تایم در سالیدیتی
    1 seconds
    1 minutes ~ 60 seconds
    1 hours ~ 60 minutes
    1 days ~ 24 hours
    1 weeks ~ 7 days
    1 years ~ 365 days
*/