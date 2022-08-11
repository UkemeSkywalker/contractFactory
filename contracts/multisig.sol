// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract MultiSig {
    ///A contract that allows 70% of validSigner to Approve before a withdrawal can be succesful

    address[] validSigner;
    uint256 ID = 1;
    uint256 public Quorum = 3;
    //maping of trnsaction Id to number of approval to status
    mapping(uint256 => mapping(uint256 => bool)) _approved;
    //mapping of transactionId to number of approval
    mapping(uint256 => uint256) public noOfApproval;
    //checking if an address has approved a particular transactionID
    mapping(address => mapping(uint256 => bool)) signed;
    mapping(uint256 => address) beneficiary;
    mapping(uint256 => uint256) amount;

    constructor(address[] memory _validSigner) {
        validSigner = _validSigner;
    }

    function withdrawEther(uint256 _amount) external {
        Approve(ID);
        beneficiary[ID] = msg.sender;
        amount[ID] = _amount;
        ID++;
    }

    function validOwner() private view returns (bool success) {
        address valid;

        for (uint256 i = 0; i < validSigner.length; i++) {
            if (msg.sender == validSigner[i]) {
                valid = msg.sender;
            }
        }
        assert(valid != address(0));
        success = true;
    }

    function Approve(uint256 id) public {
        uint256 value = amount[id];
        address _ben = beneficiary[id];
        assert(signed[msg.sender][id] == false);
        signed[msg.sender][id] = true;
        noOfApproval[id] = noOfApproval[id] + 1;
        if (noOfApproval[id] >= Quorum) {
            _approved[id][noOfApproval[id]] = true;
            payable(_ben).transfer(value);
        }
    }

    function contractBalance() external view returns (uint256) {
        return address(this).balance;
    }

    receive() external payable {}

    fallback() external payable {}
}
//["0x5B38Da6a701c568545dCfcB03FcB875f56beddC4","0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2","0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db","0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB","0x617F2E2fD72FD9D5503197092aC168c91465E7f2"]
