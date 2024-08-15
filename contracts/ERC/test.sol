// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "hardhat/console.sol";

abstract contract TokenMarketPlace is Ownable {
    using SafeERC20 for IERC20;
    using SafeMath for uint;

    uint public tokenPrice = 2e16 wei; // 0.02 ether per GLD token
    uint public sellerCount = 1;
    uint public buyerCount = 1;

    IERC20 public gldToken;

    event TokenPriceUpdated(uint newPrice);
    event TokenBought(address indexed buyer, uint amount, uint totalCost);
    event TokenSold(
        address indexed seller,
        uint amount,
        uint totalEarned
    );
    event TokensWithdrawn(address indexed owner, uint amount);
    event EtherWithdrawn(address indexed owner, uint amount);
    event CalculateTokenPrice(uint priceToPay);

    constructor(address _gldToken) Ownable(msg.sender) {
        gldToken = IERC20(_gldToken);
    }

    // Updated logic for token price calculation with safeguards
    function adjustTokenPriceBasedOnDemand() public {
        //buyerCount = 5
        //sellerCount = 1
        //markedDemand ratio =
        //buyerCount.mul(1e18).div(sellerCount) = 5*10^18 /1 = 5*10^18
        //adjustedRatio = (5*10^18 + 1*10^18)/2 = (6 * 10^18)/2 = 3 * 10^18
        // newTokenPrice = //(2 * 10^16 * 3 * 10^18) / 10^18 = (6 * 10^34)/10^18 = 6*10^16 wei = 0.06 ether
        uint marketDemandRatio = buyerCount.mul(1e18).div(sellerCount);
        //
        uint smoothingFactor = 1e18;

        uint adjustedRatio = marketDemandRatio.add(smoothingFactor).div(2);

        //
        uint newTokenPrice = tokenPrice.mul(adjustedRatio).div(1e18);
        uint minimumPrice = 2e16;

        if (newTokenPrice < minimumPrice) {
            newTokenPrice = minimumPrice;
        }
        tokenPrice = newTokenPrice;
    }

    // Buy tokens from the marketplace
    function buyGLDToken(uint _amountOfToken) public payable {
        require(_amountOfToken > 0, "Invalid token amount");
        uint requiredTokenPrice = calculateTokenPrice(_amountOfToken);
        require(requiredTokenPrice == msg.value, "Incorrect token price paid");
        // (bool success, ) = payable(msg.sender).call{value: requiredTokenPrice}("");

        // require(success, "Token purchased successfully");
        gldToken.safeTransfer(msg.sender, _amountOfToken);
        buyerCount += 1;
        emit TokenBought(msg.sender, _amountOfToken, requiredTokenPrice);
    }

    function calculateTokenPrice(uint _amountOfToken)
        public
        returns (uint)
    {
        require(_amountOfToken > 0, "AmountOfToken > 0");
        adjustTokenPriceBasedOnDemand();
        uint amountToPay = _amountOfToken.mul(tokenPrice).div(1e18);

        console.log("Amount to Pay: ", amountToPay);
        return amountToPay;
    }

    // Sell tokens back to the marketplace
    function sellGLDToken(uint _amountOfToken) public {
        require(gldToken.balanceOf(msg.sender) >= _amountOfToken, "Invalid token amount");
        uint priceToPayToUser = calculateTokenPrice(_amountOfToken);
        gldToken.safeTransferFrom(msg.sender,address(this),_amountOfToken);
        (bool success,) = payable (msg.sender).call{value:priceToPayToUser}("");
        require(success,"Transaction failed");
        sellerCount += 1;
        emit TokenSold(msg.sender, _amountOfToken, priceToPayToUser);

    }

    // Owner can withdraw excess tokens from the contract
    function withdrawTokens(uint amount) public onlyOwner {
        require(gldToken.balanceOf(address(this))>amount,"Out of balance");
        gldToken.safeTransfer(msg.sender, amount);
        emit TokensWithdrawn(msg.sender,amount);
    }

    // Owner can withdraw accumulated Ether from the contract
    function withdrawEther(uint amount) public onlyOwner {
        


    }
}
