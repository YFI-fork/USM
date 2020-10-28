// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.6.6;
import "./IOracle.sol";
import "@nomiclabs/buidler/console.sol";


interface IMakerPriceFeed {
    function read() external view returns (bytes32);
}

contract MakerOracle is IOracle {
    IMakerPriceFeed public medianizer;
    uint public override decimalShift;

    /**
     * @notice Mainnet details:
     * medianizer: 0x729D19f657BD0614b4985Cf1D82531c67569197B
     * decimalShift: 18
     */
    constructor(address medianizer_, uint decimalShift_) public {
        medianizer = IMakerPriceFeed(medianizer_);
        decimalShift = decimalShift_;
    }

    function latestPrice() external override view returns (uint) {
        // From https://studydefi.com/read-maker-medianizer/:
        return uint(medianizer.read());
    }

    // TODO: Remove for mainnet
    function latestPriceWithGas() external returns (uint256) {
        uint gas = gasleft();
        uint price = this.latestPrice();
        console.log("        makerOracle.latestPrice() cost: ", gas - gasleft());
        return price;
    }
}