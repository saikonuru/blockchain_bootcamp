// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract Vote {
    struct Voter {
        string name;
        uint256 age;
        uint256 voterId;
        Gender gender;
        uint256 voteCandidateId;
        address voterAddress;
    }

    struct Candidate {
        string name;
        string party;
        uint256 age;
        Gender gender;
        uint256 candidateId;
        address candidateAddress;
        uint256 votes;
    }

    address electionCommission;
    address public winner;
    uint256 nextVoterId = 1;
    uint256 nextCandidateId = 1;
    uint256 startTime;
    uint256 endTime;
    bool stopVoting;

    mapping(uint256 => Voter) voterDetails;
    mapping(uint256 => Candidate) candidateDetails;

    enum VotingStatus {
        NotStarted,
        InProgress,
        Ended
    }
    enum Gender {
        NotSpecified,
        Male,
        Female,
        Other
    }

    constructor() {
        electionCommission = msg.sender;
    }

    modifier isVotingOver() {
        require(
            block.timestamp < endTime && stopVoting == false,
            "Voting Completed"
        );
        _;
    }

    modifier ageCheck(uint256 _age) {
        require(_age >= 18, "You are below 18");
        _;
    }

    modifier onlyCommissioner() {
        require(msg.sender == electionCommission, "You are not authorized");
        _;
    }

    // use calldata to make the variable as immumutable
    // memory mutable
    function registerCandidate(
        string calldata _name,
        string calldata _party,
        uint256 _age,
        Gender _gender
    ) external {
        candidateDetails[nextCandidateId] = Candidate({
            name: _name,
            party: _party,
            age: _age,
            gender: _gender,
            candidateId: nextCandidateId,
            candidateAddress: msg.sender,
            votes: 0
        });
        nextCandidateId++;
    }

    function isCandidateNotRegistered(address _person)
        internal
        view
        returns (bool)
    {
        for (uint256 i = 1; i < nextCandidateId; i++) {
            if (candidateDetails[i].candidateAddress == _person) return false;
        }

        return true;
    }

    function getCandidateList() public view returns (Candidate[] memory) {}

    function isVoterNotRegistered(address _person)
        internal
        view
        returns (bool)
    {
        for (uint256 i = 0; i < nextVoterId; i++) {
            if (voterDetails[i].voterAddress == _person) {
                return false;
            }
        }
        return true;
    }

    function registerVoter(
        string calldata _name,
        uint256 _age,
        Gender _gender
    ) external ageCheck(_age) {
        require(isVoterNotRegistered(msg.sender), "You are already registered");
        require(
            msg.sender != electionCommission,
            "Eleion comission not allowed to regisrter"
        );

        voterDetails[nextVoterId] = Voter({
            name: _name,
            age: _age,
            gender: _gender,
            voterAddress: msg.sender,
            voterId: nextVoterId,
            voteCandidateId: 0
        });
        nextVoterId++;
    }

    function getVoterList() public view returns (Voter[] memory) {
        Voter[] memory _list;

        for (uint256 i = 1; i < nextVoterId; i++) {
            _list[i] = voterDetails[i];
        }

        return _list;
    }

    function castVote(uint256 _voterId, uint256 _id) external {}

    function setVotingPeriod(uint256 _startTime, uint256 _endTime)
        external
        onlyCommissioner
    {}

    function getVotingStatus() public view returns (VotingStatus) {}

    function announceVotingResult() external onlyCommissioner {}

    function emergencyStopVoting() public onlyCommissioner {
        stopVoting = true;
    }
}
