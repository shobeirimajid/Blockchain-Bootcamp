// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.0 <0.8.11;


contract Ballot {


    ///////////////////////////////////
    //         State Variables       //
    ///////////////////////////////////


    struct Proposal {
        uint8 voteCount;
        string name;
    }                                   
                                        
    Proposal[] public proposalList;                                     

    struct Voter {
        uint8 vote;
        uint8 weight;
        bool voted;
    }

    mapping(address => Voter) public voterList;     
    address public chairPerson;


    ///////////////////////////////////
    //           constructor         //
    ///////////////////////////////////


    constructor(uint8 proposalCount) {
        chairPerson = msg.sender;
        voterList[chairPerson].weight = 2;

        for(uint8 i=0; i<proposalCount; i++){
            proposalList.push( Proposal({voteCount:0, name:""}) );
        }
    }


    ///////////////////////////////////
    //            modifiers          //
    ///////////////////////////////////


    modifier onlyChairPerson() {
        // فقط مدیر اجازه ثبت نام بقیه راهی دهنده ها را دارد
        require(msg.sender == chairPerson, "Only Chairperson Can Register Others!");
        _;
    }

    modifier chairPersonCantReg(address voterAdr) {
        // مدیر نباید برای خودش ثبت نام انجام دهد
        require(voterAdr != chairPerson, "Chairperson Can't Register Again!");
        _;
    }

    modifier alreadyVoted(address voterAdr) {
        // قبلا نباید رای داده باشد
        require(voterList[voterAdr].voted == false, "Already Voted!");
        _;
    }

    modifier validProposalID(uint8 proposalID) {
        // شناسه پروپوزال باید معتبر باشد
        require(proposalID >= 0 && proposalID < proposalList.length, "Invalid ProposalID!");
        _;
    }

    modifier registered() {
        // رای دهنده قبلا باید ثبت نام را انجام داده باشد
        require(voterList[msg.sender].weight > 0, "You don't Registered Yet!");
        _;
    }


    ///////////////////////////////////
    //           functions           //
    ///////////////////////////////////


    function register(address voterAdr) public onlyChairPerson chairPersonCantReg(voterAdr) alreadyVoted(voterAdr) {
        // ثبت نام رای دهنده
        voterList[voterAdr].weight = 1;
    }

    function vote(uint8 proposalID) public validProposalID(proposalID) registered alreadyVoted(msg.sender) {
        // اطلاعات رای را ثبت میکنیم
        voterList[msg.sender].vote = proposalID;
        voterList[msg.sender].voted = true;

        // بروزرسانی مجموع آراء جمع آوری شده توسط پروپوزال مورد نظر
        proposalList[proposalID].voteCount += voterList[msg.sender].weight;
    }

    function count() public view returns(uint8 winnerPropID, uint8 winnerPropVoteCount) {
        uint256 proposalCount =  proposalList.length;
        for(uint8 i=0; i<proposalCount; i++) {
            if(proposalList[i].voteCount > winnerPropVoteCount) {
                winnerPropID = i;
                winnerPropVoteCount = proposalList[i].voteCount;
            }
        }

        // پروپوزال های با رای یکسان که شرایط بنده شدن دارند را در یک آرایه مجزا درج میکنیم
        // سپس بین پروپوزال های با رای مساوی قرعه کشی انجام میدهد
        uint8[] memory winPropList = new uint8[](proposalCount);
        uint8 j = 0;
        for(uint8 i=0; i<proposalCount; i++) {
            if(proposalList[i].voteCount == winnerPropVoteCount) {
                winPropList[j] = i;
                j++;
            }
        }
        winnerPropID = winPropList[getRand(j)];

        return (winnerPropID, winnerPropVoteCount);
    }

    function getRand(uint8 max) public view returns (uint8) {
       return uint8(uint256(keccak256(abi.encodePacked(block.difficulty, block.timestamp)))) % max;
    }

}