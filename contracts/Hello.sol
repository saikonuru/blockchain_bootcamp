// SPDX-License-Identifier: GPL-3.0

/**
 * @title Hello
 * @dev ContractDescription
 * @custom:dev-run-script NatSpec
 */

pragma solidity >=0.8.2 <0.9.0;

contract Hello {
    string name;

    function store_value(string memory value) public {
        name = value;
    }

    function get_block_number() external view returns (uint256) {
        //block - read only
        return block.number;
    }

    //call data- immutability
    function StringManupulation(uint256[3] calldata _arr)
        external
        pure
        returns (uint256[3] calldata)
    {
        //_arr[0] =1; // not allowed with calldata
        return _arr;
    }

    //memory - mutability - change is allowed
    function StringManupulation2(uint256[3] memory _arr)
        external
        pure
        returns (uint256[3] memory)
    {
        _arr[0] = 1; // not allowed with calldata , with memory allowd
        return _arr;
    }

    uint256[3] arr;

    function StringManupulation3() external view returns (uint256[3] memory) {
        return arr;
    }

    struct Candidate {
        uint256 age;
        string name;
    }

    struct Voter {
        uint256 age;
        string name;
        uint256 voteCandidateId;
        address voterAddress;
    }

    uint256 nextCandidateId;
    Candidate[] candidateDetails = new Candidate[](10);

    function getCandidateList() public view returns (Candidate[] memory) {
        Candidate[] memory candidateList = new Candidate[](nextCandidateId - 1);

        for (uint256 i = 0; i < candidateList.length; i++) {
            candidateList[i] = candidateDetails[i + 1];
        }
        return candidateList;
    }

    Voter[] voterDetails = new Voter[](10);

    function castVote(uint256 _voterId, uint256 _candidateId) external {
        require(
            voterDetails[_voterId].voteCandidateId == 0,
            "You have already voted"
        );
        require(
            voterDetails[_voterId].voterAddress == msg.sender,
            "You are not authourized"
        );
        require(
            _candidateId >= 1 && _candidateId < 3,
            "Candidate Id is not correct"
        );
        voterDetails[_voterId].voteCandidateId = _candidateId; //voting to _candidateId candidateDetails[_candidateId].votes++; //increment _candidateId votes
    }
}
