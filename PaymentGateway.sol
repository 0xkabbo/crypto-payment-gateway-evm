// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract PaymentGateway is Ownable {
    event PaymentReceived(
        address indexed customer,
        uint256 amount,
        address token,
        string orderId
    );

    constructor() Ownable(msg.sender) {}

    // Accept Native ETH/BNB/MATIC
    function payWithNative(string calldata _orderId) external payable {
        require(msg.value > 0, "Amount must be greater than 0");
        emit PaymentReceived(msg.sender, msg.value, address(0), _orderId);
    }

    // Accept ERC-20 Tokens (USDC, USDT, etc.)
    function payWithToken(
        address _token,
        uint256 _amount,
        string calldata _orderId
    ) external {
        IERC20 token = IERC20(_token);
        require(token.transferFrom(msg.sender, address(this), _amount), "Transfer failed");
        emit PaymentReceived(msg.sender, _amount, _token, _orderId);
    }

    // Withdraw Native Funds
    function withdrawNative() external onlyOwner {
        payable(owner()).transfer(address(this).balance);
    }

    // Withdraw ERC-20 Tokens
    function withdrawToken(address _token) external onlyOwner {
        IERC20 token = IERC20(_token);
        uint256 balance = token.balanceOf(address(this));
        token.transfer(owner(), balance);
    }
}
