// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract MyERC20 {
    string public name = "MyToken";
    string public symbol = "MTK";
    uint8 public decimals = 18;
    uint public totalSupply;
    address public owner;
    mapping (address => uint256) public balanceOf;
    mapping (address => mapping (address => uint256)) public allowance;

    constructor() {
        owner = msg.sender;
    }

    event Transfer(address indexed from, address indexed to, uint amount);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    // 转账
    function transfer(address to, uint amount) public returns (bool) {
        require(balanceOf[msg.sender] >= amount, "Not enough balance");
        balanceOf[msg.sender] -= amount;
        balanceOf[to] += amount;
        emit Transfer(msg.sender, to, amount);
        return true;
    }

    //授权
    function approve(address spender, uint256 value) public returns (bool success){
         allowance[msg.sender][spender] = value;
         emit Approval(msg.sender, spender, value);
        return true;
    }

    // 代扣
    function transferFrom(address from, address to, uint amount) public returns (bool) {
        require(balanceOf[from] >= amount, "Balance not enough");
        require(allowance[from][msg.sender] >= amount, "Not approved");
        allowance[from][msg.sender] -= amount;
        balanceOf[from] -= amount;
        balanceOf[to] += amount;
        emit Transfer(from, to, amount);
        return true;
    }

    //增发代币
    function mint(address receiver, uint256 amount) public onlyOwner {
        require (amount > 0,"invalid token");
         balanceOf[receiver] += amount;
         totalSupply += amount;
         emit Transfer(address(0), receiver, amount);
    }
}