// SPDX-License-Identifier: MIT
pragma solidity  ^0.8.4;

contract Multisig {

    // 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
    // 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
    // 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db

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
            
        }
        assert(valid != address(0));
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

    receive() external payable{}

    fallback()external payable{}

}