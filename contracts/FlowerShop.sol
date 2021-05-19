// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
contract FlowerShop is Ownable {
    using SafeMath for uint256;

    struct Flower {
        address addr;
        // Real price should times 10^-18 as the coin has 18 decimals for BNB
        uint256 price;
        bool isFlower;
    }

    mapping(bytes32 => Flower) public flowers;

    ERC20 public ERC20Interface;

    event Buy(address indexed from_, address indexed to_, uint256 amount_);

    function _isFlower(bytes32 symbol_) private view returns (bool) {
        return flowers[symbol_].isFlower;
    }

    function addFlower(bytes32 symbol_, address address_, uint256 price_) public onlyOwner returns (bool) {
        require(!_isFlower(symbol_), "Flower already exists");
        flowers[symbol_] = Flower(address_, price_, true);
        return true;
    }

    function removeFlower(bytes32 symbol_) public onlyOwner returns (bool) {
        require(_isFlower(symbol_), "Flower not exists");
        delete(flowers[symbol_]);
        return true;
    }

    function updateFlower(bytes32 symbol_, address address_, uint256 price_) public onlyOwner returns (bool) {
        require(_isFlower(symbol_), "Flower not exists");
        flowers[symbol_].addr = address_;
        flowers[symbol_].price = price_;
        return true;
    }

    function flowerExists(bytes32 symbol_) public view returns (bool) {
        return _isFlower(symbol_);
    }

    function flowerPrice(bytes32 symbol_) public view returns (uint256) {
        require(_isFlower(symbol_), "Flower not exists");
        return flowers[symbol_].price;
    }

    function flowerAddress(bytes32 symbol_) public view returns (address) {
        require(_isFlower(symbol_), "Flower not exists");
        return flowers[symbol_].addr;
    }

    function buy(bytes32 symbol_, uint256 amount_) public payable returns (bool) {
        require(_isFlower(symbol_), "We don't sell this flower");
        require(
            msg.value >= amount_.mul(flowers[symbol_].price),
            "You need pay more money to buy the flowers"
        );
        ERC20Interface = ERC20(flowers[symbol_].addr);
        require(ERC20Interface.transfer(msg.sender, amount_), "The flowers out of stock");
        emit Buy(address(this), msg.sender, amount_);
        return true;
    }

    event Received(address, uint);

    receive() external payable {
        emit Received(msg.sender, msg.value);
    }

    function withdraw(address payable beneficiary) public payable onlyOwner {
        beneficiary.transfer(address(this).balance);
    }
}
