pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract ERC721Token is ERC721 {
    mapping(uint256 => uint256) private _tokenIdToAmount;
    mapping(uint256 => address) private _tokenIdToERC20;

    constructor(
        string memory _name,
        string memory _symbol
    ) ERC721(_name, _symbol) {}

    function mint(
        address _to,
        uint256 _tokenId,
        address _erc20Token,
        uint256 _amount
    ) external {
        require(_amount > 0, "Amount must be greater than zero");
        require(_erc20Token != address(0), "Invalid ERC20 token address");

        _safeMint(_to, _tokenId);
        _tokenIdToAmount[_tokenId] = _amount;
        _tokenIdToERC20[_tokenId] = _erc20Token;
    }

    function transferERC721(uint256 _tokenId, address _to) external {
        require(_exists(_tokenId), "Token does not exist");
        require(ownerOf(_tokenId) == msg.sender, "Not the token owner");

        _transfer(msg.sender, _to, _tokenId);
    }

    function transferERC20(uint256 _tokenId, address _to) external {
        require(_exists(_tokenId), "Token does not exist");
        require(ownerOf(_tokenId) == msg.sender, "Not the token owner");

        address erc20Token = _tokenIdToERC20[_tokenId];
        uint256 amount = _tokenIdToAmount[_tokenId];
        require(erc20Token != address(0), "Invalid ERC20 token address");

        IERC20(erc20Token).transferFrom(msg.sender, _to, amount);
    }
}
