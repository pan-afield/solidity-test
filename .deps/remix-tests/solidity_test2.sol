// SPDX-License-Identifier: MIT
pragma solidity ~0.8.0;

contract C { 
    // 反转字符串
    function reverseString(string memory str) public pure returns (string memory) {
        uint len = bytes(str).length;
        bytes memory reversed = new bytes(len);

        for (uint i = 0; i < len; ++i) {
            reversed[i] = bytes(str)[len - 1 - i];
        }

        return string(reversed); // 返回反转后的字符串
    }
}