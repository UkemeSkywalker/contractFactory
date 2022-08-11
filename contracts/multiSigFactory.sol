// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.9;

import "./multisig.sol";

contract MultiSigFactory {

    MultiSig[] multiSigAddresses;

    function cloneMultiSig(address[] memory _validOwners) external returns(MultiSig newMS, uint _length){
        newMS = new MultiSig(_validOwners);
        multiSigAddresses.push(newMS);
        _length = multiSigAddresses.length;
    }

    function clonedAddresses() external view returns(MultiSig[] memory _MultiSig){
        _MultiSig = multiSigAddresses;

    

    }
}