pragma solidity ^0.4.24;
library SafeMath {
    function mul(uint256 a, uint256 b) internal pure returns (uint256 c) {
        if (a == 0) {
            return 0;
        }
        c = a * b;
        assert(c/a==b);
        return c;
    }
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        assert(b <= a);
        return a - b;
    }
    function add(uint256 a, uint256 b) internal pure returns (uint256 c) {
        c = a + b;
        assert(c>=a);
        return c;
    }
}
contract Token {
    using SafeMath for uint256;
    string constant public name = "Token";
     string constant public symbol = "TOKEN";
     uint8 constant public decimals = 18;
     uint256 private __totalSupply = 1000000000e18;
     address public ownerAddr;
    mapping (address => uint256) balances;
    mapping (address => mapping (address => uint)) allowed;
    constructor (address _ownerAddr) public {
        ownerAddr = _ownerAddr;
        balances[ownerAddr] = __totalSupply;
    }
    function totalSupply() public view returns (uint256 _totalSupply) {
        _totalSupply = __totalSupply;
    }
    function balanceOf(address _owner) public view returns (uint256) {
        return balances[_owner];
    }
    function allowance(address _owner, address _spender) public view returns (uint256) {
        return allowed[_owner][_spender];
    }
    function transfer(address _to, uint256 _value) public returns(bool) {
        require(_value <= balances[msg.sender]);
        require(_to != address(this));
        balances[msg.sender] = balances[msg.sender].sub(_value.mul(10**18));
        balances[_to] = balances[_to].add(_value.mul(10**18));
        emit Transfer(msg.sender, _to, _value.mul(10**18));
        return true;
    }
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
    function transferFrom(address _from, address _to, uint256 _value) public returns(bool) {
        require(_value <= balances[_from]);
        require(_value <= allowed[_from][msg.sender]);
        require(_to != address(this));
        
        balances[_from] = balances[_from].sub(_value);
        balances[_to] = balances[_to].add(_value);
        allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_value);
        emit Transfer(_from, _to, _value);
        return true;
    }
    function approve(address _spender, uint256 _value) public returns (bool) {
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }
}
