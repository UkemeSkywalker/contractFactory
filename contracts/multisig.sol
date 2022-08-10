// SPDX-License-Identifier: MIT
pragma solidity  ^0.8.4;

contract Multisig {


    // A contract that allows 70% of ValidSigner to approve before a withrawal is successful.
    address[] validSigner;
    uint ID;
    uint Quorum = (validSigner.length * 70) / 100;
    //mapping of transactionID to number of approval to status
    mapping (uint => mapping(uint => bool)) _approved;
    //mapping of transactionId to number of approval
    mapping (uint => uint) noOfApproval;    
    //checking id an addess gas approved a particular transactionID
    mapping (address => mapping(uint => bool)) signed;
    mapping(uint => address) beneficiary;
    mapping(uint => uint) amount;
    constructor(address[] memory _validSigner) {
        validSigner = _validSigner;
    }

    function withdrawEther(uint _amount) external {
        bool _valid = validOwners();
        Approve(ID);
        beneficiary[ID] = msg.sender;
        amount[ID] = _amount;
    }

    function validOwners() private view returns(bool success){
        address valid;
        for(uint i = 0;  i < validSigner.length; i++){
            if(msg.sender == validSigner[i]){
                valid = msg.sender;
            }
            require(msg.sender != address(0), "can not be address zero");
        }
        success = true;
    }

    function Approve(uint id) public{
        bool valid = validOwners();
        uint Value  = amount[id];
        address _beneficiary = beneficiary[id];
        assert(signed[msg.sender][id] == false);
        uint num = noOfApproval[id]+ 1;
        if(num >= Quorum){
            _approved[id][num] = true;
            payable(_beneficiary).transfer(Value);
        }
    }
}