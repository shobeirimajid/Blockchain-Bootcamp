// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

contract Ballot {

    /*
        موجودیت ها - Entities
            1-Proposal : struct     ,       proposalList : Proposal[]
            2-Voter : struct        ,       voterList : mapping(address => Voter)
            3-chairPerson : address

        عملکردها - Functions
            1-register() - ثبت نام رای دهنده ها
            2-vote() - رای دادن
            3-count() - شمارش آرا و اعلام برنده
    */

    ///////////////////////////////////
    ////////     Entities      ////////
    ///////////////////////////////////

    struct Proposal {
        string name;
        uint8 voteCount;
    }

    Proposal[] public proposalList;     //  [  {name:name1, voteCount:voteCount1} , {name:name2, voteCount:voteCount2} , ... ]
                                        //  ProposalList[0].name    یا   ProposalList[0].voteCount
                                        //  ProposalList[0].voteCount += 1
    
    struct Voter {
        uint8 vote;         // اندیس پروپوزالی که به آن رای داده شده
        uint8 weight;       // افراد عادی: 1   و   مدیر: 2
        bool voted;         // رای داده:true  |  هنوز رای نداده:false
    }

    mapping(address => Voter) public voterList;

    address public chairPerson;

    constructor(uint8 proposalCount) {

        chairPerson = msg.sender;

        // ثبت نام مدیر جلسه
        // weight : 0   => ثبت نام نکرده
        // weight > 0   => ثبت نام انجام داده
        voterList[chairPerson].weight = 2;

        for(uint i=0; i<proposalCount; i++) {
            proposalList.push( Proposal( { name:"", voteCount:0 } ) );
        }
    }


    ////////////////////////////////////
    ////////     Functions      ////////
    ////////////////////////////////////

    /*  Call only by chairPerson   */
    function register(address voterAdr) public {

        // فقط مدیر اجازه ثبت نام بقیه راهی دهنده ها را دارد
        require(msg.sender == chairPerson, "Only chairperson can call register()");

        // مدیر نباید برای خودش ثبت نام انجام دهد
        require(voterAdr != chairPerson, "Chairperson Can't Register Again!");

        // ثبت نام شونده نباید قبلا رای داده باشد
        require(voterList[voterAdr].voted == false, "Voter Already Voted!");

        // ثبت نام رای دهنده
        voterList[voterAdr].weight = 1;
    }


    /*  Call by chairPerson and other voters   */
    function vote(uint8 proposalId) public {

        // شناسه پروپوزال باید معتبر باشد
        require(proposalId >= 0 && proposalId < proposalList.length, "Invalid ProposalID!");   

        // رای دهنده قبلا باید ثبت نام را انجام داده باشد
        require(voterList[msg.sender].weight > 0, "You don't Registered Yet!");

        // رای دهنده قبلا نباید رای داده باشد
        require(voterList[msg.sender].voted == false, "Voter Already Voted!");

        // اطلاعات رای را ثبت میکنیم
        voterList[msg.sender].vote = proposalId;
        voterList[msg.sender].voted = true;

        // بروزرسانی مجموع آرای جمع آوری شده توسط پروپوزال مورد نظر
        proposalList[proposalId].voteCount += voterList[msg.sender].weight;
    }


    function count() public view returns(uint8 winnerPropId, uint8 winnerPropVoteCount) {

        // uint8 winnerPropID;
        // uint8 winnerPropVoteCount;      // default : 0

        for(uint8 i=0; i<proposalList.length; i++) {

            if(proposalList[i].voteCount > winnerPropVoteCount) {
                winnerPropVoteCount = proposalList[i].voteCount;    // تعداد رای برنده
                winnerPropId = i;                                   // اندیس برنده 
            }
        }

        //return (winnerPropID, winnerPropVoteCount);
    }
}
// TODO: [1, 2, 6, 3, 6]    =>  [2,4] -> random(1) -> winner



/*

    chairperson: 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4

    Proposals: 
                PropID 0  -- voteCount : 2
                PropID 1  -- voteCount : 2
                PropID 2  -- voteCount : 1


    voters:
                0: chairperson :    0x5B38Da6a701c568545dCfcB03FcB875f56beddC4 -- vote: 1
                1:                  0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2 -- vote: 0
                2:                  0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db -- vote: 0
                3:                  0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB -- vote: 2

    Winner:
                winnerPropID : 0
                winnerPropVoteCount : 2
*/