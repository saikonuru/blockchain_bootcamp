// SPDX-License-Identifier: GPL-3.0
//July 04
pragma solidity >=0.8.2 <0.9.0;
import "hardhat/console.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract RequireTest {
    int public num;

    function requireTest(int256 a) public {
        require(a > 0, "a is not greater than 0");
        num = a;
    }

    function conditionals(uint b) public returns (string memory) {
        
        for (uint i = 0; i < b; i++) {
            console.log(string.concat("i ->", Strings.toString(i+1)));
        }

        num = 200;
        if (b > 0) {
            num = int(b);
        } else {
            return "b is not greater than Zero";
        }
        return "Success";
    }
}
