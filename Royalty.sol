pragma solidity ^0.4.24;

contract ERC20 {
    function totalSupply() public constant returns (uint);
    function balanceOf(address tokenOwner) public constant returns (uint balance);
    function allowance(address tokenOwner, address spender) public constant returns (uint remaining);
    function transfer(address to, uint tokens) public returns (bool success);
    function approve(address spender, uint tokens) public returns (bool success);
    function transferFrom(address from, address to, uint tokens) public returns (bool success);
    event Transfer(address indexed from, address indexed to, uint tokens);
    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
}

contract HaiPowerRoyaly {
    
    address HaiPowerContractAddress = 0x89F838CaE3A53bB8cD27B9A78801A1d68F39BB97;
    address public owner;
    constructor() public {
        owner = msg.sender;
    }
    mapping ( address => uint256 ) public balances;
    
    function deposit(uint tokens) public {
        balances[msg.sender]+= tokens;
        ERC20(HaiPowerContractAddress).transferFrom(msg.sender, address(this), tokens);
    }

    function payRoyalty(address holderAddress, uint percentage) public onlyOwner {
        _before = balances[holderAddress];
        _after = (_before * percentage)/100;
        balances[holderAddress] = _before + _after;
        balances[owner] = balances[owner] - _after;
    }

    function returnTokens() public {
        ERC20(HaiPowerContractAddress).transfer(msg.sender, balances[msg.sender]);
        balances[msg.sender] = 0;
    }
}