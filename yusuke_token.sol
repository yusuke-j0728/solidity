pragma solidity ^0.5.1;

contract DappToken {
    string public name = "Yusuke Token";
    string public symbol = "Yusuke";
    string public standard = "Yusuke Token v1.0";
    uint256 public totalSupply;
    address public owner = address(0); //Variable initialization
    address public admin = address(0); //Variable initialization
    address public minter;             //Variable initialization // same impact as above       


    event Transfer(
        address indexed _from,
        address indexed _to,
        uint256 _value
    );

    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 _value
    );

    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    // Constructor
    // Set the total number of tokens
    // Read the total number of tokens

    // constructor() public {
    //     totalSupply = 1000000;
    // }
    constructor(uint256 _initialSupply) public {
        totalSupply = _initialSupply;
        // allocate the initial supply
        balanceOf[msg.sender] = _initialSupply;
        // test mint
        _mint(msg.sender, _initialSupply);
        owner = msg.sender;
    }

    // transfer
    function transfer(address _to, uint256 _value) public returns(bool success) {
        // exception if account doesn't have enough
        require(balanceOf[msg.sender] >= _value);
        // transfer the balance
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        // transfer event
        emit Transfer(msg.sender, _to, _value);
        // return a boolean
        return true;
    }

    // approve
    function approve(address _spender, uint256 _value) public returns(bool success) {
        // allowance
        allowance[msg.sender][_spender] = _value;
        // approve event
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    // delegated transfer
    // transferfrom
    function transferFrom(address _from, address _to, uint256 _value) public returns(bool success) {
        // require _from has enough tokens
        require(_value <= balanceOf[_from]);
        // require allowance is big enough
        require(_value <= allowance[_from][msg.sender]);
        // change the balance
        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
        // update the allowance
        allowance[_from][msg.sender] -= _value;
        // transfer event
        emit Transfer(_from, _to, _value);
        // return a boolean
        return true;
    }
    
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");
        return c;
    }
    
    function _mint(address account, uint256 amount) internal {
        require(account != address(0), "ERC20: mint to ther zero address");
        //totalSupply = totalSupply.add(amount);
        totalSupply = totalSupply + amount;
        balanceOf[account] = balanceOf[account] + amount;
        emit Transfer(address(0),account, amount);
    }
    
    function mint(address account, uint256 amount) public returns (bool success) {
        _mint(account, amount);
        return true;
    }
    
    function burn(address account, uint256 amount) public returns (bool success) {
        require(account != address(0), "ERC20: burn from the zero address") ;
        balanceOf[account] = balanceOf[account] - amount;
        totalSupply = totalSupply - amount;
        emit Transfer(account, address(0), amount);
        return true;
    }
    
}