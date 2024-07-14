// SPDX-License-Identifier: GPL-3.0
// July 04
pragma solidity >=0.8.2 <0.9.0;

contract Parent {
    function f1() public pure returns (string memory) {
        // f2();
        // f3();
        // f4(); // not allowed
         return "1";
    }

    function f2() private pure returns (string memory) {
        // f1();
        // f3();
        // f4();
        return "2";
    }

    function f3() internal pure returns (string memory) {
        // f1();
        // f2();
        // f4(); // not allowed
        return "3";
    }

    function f4() external pure returns (string memory) {
        // f1();
        // f2();
        // f3();
        return "4";
    }
    
    function f5() external pure returns (string memory) {
        // f1();
        // f2();
        // f3();
        //f4(); //not allowed
        return "4";
    }

}

contract Child is Parent {
    function f6() public pure {
        f1();
        f3();
    }
}

contract ExternalContract {
    Parent p1 = new Parent();

    function f5() public view {
        p1.f1();
        p1.f4();
    }
}
