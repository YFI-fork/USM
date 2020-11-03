// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.6.6;
import "../oracles/Oracle.sol";
import "@nomiclabs/buidler/console.sol";

abstract contract GasMeasuredOracle is Oracle {
    string internal _name;

    constructor(string memory name_) public {
        _name = name_;
    }

    function name() external virtual view returns (string memory) {
        return _name;
    }

    function latestPriceWithGas() public virtual view returns (uint price) {
        string memory name_ = this.name();
        uint gas = gasleft();
        price = this.latestPrice();
        console.log("        ", name_, "oracle.latestPrice() cost: ", gas - gasleft());
    }
}