// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.4.22 <0.9.0;

contract Votoing {
    mapping (string owner => address[] account) public voterList;
    //候选人集合
    string[] public owners;

    // 投票
    function vote(string memory owner, address account_) public  {
        // 检查候选人是否已经存在
        bool exists = false;
        for (uint i = 0; i < owners.length; i++) {
            if (keccak256(abi.encodePacked(owners[i])) == keccak256(abi.encodePacked(owner))) {
                exists = true;
                break;
            }
        }

        // 如果候选人不存在，添加到所有候选人数组
        if (!exists) {
            owners.push(owner);
        }
        voterList[owner].push(account_);
    }


    // 得票数
    function getVotes(string memory owner) public view returns (uint len){
        return voterList[owner].length;
    }

    // 重置所有候选人得票数
    function resetVotes() public {
        for (uint i = 0; i < owners.length; i++) {
            delete voterList[owners[i]];
        }
    }
}