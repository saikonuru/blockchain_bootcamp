// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

// contract InlineAssembly {
//     function add(uint256 a, uint256 b) public pure returns (uint256) {
//         uint256 result;
//         assembly {
//             result := add(a, b)
//         }
//         return result;
//     }
// }

contract StorageDemo {
    function storeNum(uint256 slot, uint256 value) public {
        assembly {
            sstore(slot, value)
        }
    }

    function getNum(uint256 slot) public view returns (uint256) {
        uint256 value;
        assembly {
            value := sload(slot)
        }
        return value;
    }
}

contract MemoryDemo {
    function storeAndLoad(uint256 x) public pure returns (uint256) {
        uint256 result;
        assembly {
            mstore(0x80, x)
            result := mload(0x80)
        }
        return result;
    }
}

contract OffsetAndShifting {
    uint128 public A = 22;
    uint96 public B = 15;
    uint16 public C = 7;
    uint8 public D = 100;

    function getSlot(uint256 slot) external view returns (bytes32 value) {
        assembly {
            value := sload(slot)
        }
    }

    function readValueBySlot(uint256 slot)
        external
        view
        returns (bytes32 value)
    {
        assembly {
            value := sload(slot)
        }
    }

    function getOffsetOfC()
        external
        pure
        returns (uint256 slot, uint256 offset)
    {
        assembly {
            slot := C.slot
            offset := C.offset
        }
    }

    function readValueOfA() external view returns (uint256 a) {
        assembly {
            let value := sload(A.slot)
            let shifted := shr(mul(A.offset, 8), value)
            a := and(0xfff, shifted)
        }
    }

    function readValueOfB() external view returns (uint256 b) {
        assembly {
            let value := sload(B.slot)
            let shifted := shr(mul(B.offset, 8), value)
            b := and(0xfff, shifted)
        }
    }

    function readValueOfC() external view returns (uint256 c) {
        assembly {
            let value := sload(C.slot)
            let shifted := shr(mul(C.offset, 8), value)
            c := and(0xfff, shifted)
        }
    }

    function readValueOfD() external view returns (uint256 d) {
        assembly {
            let value := sload(D.slot)
            let shifted := shr(mul(D.offset, 8), value)
            d := and(0xfff, shifted)
        }
    }

    function writeToC(uint16 newC) external {
        assembly {
            // newC = 0x000000000000000000000000000000000000000000000000000000000000000a
            let slotValue := sload(C.slot)
            // slotValue =  0x0001000800000000000000000000000f00000000000000000000000000000016

            let clearedC := and(
                slotValue,
                0xffff0000ffffffffffffffffffffffffffffffffffffffffffffffffffffffff
            )
            // mask      =  0xffff0000ffffffffffffffffffffffffffffffffffffffffffffffffffffffff
            // slotValue =  0x0001000800000000000000000000000f00000000000000000000000000000016
            // clearedC =   0x0001000000000000000000000000000f00000000000000000000000000000016
            let shiftedNewC := shl(mul(C.offset, 8), newC)
            // shiftedNewC = 0x0000000a00000000000000000000000000000000000000000000000000000000
            let newSlotValue := or(shiftedNewC, clearedC)
            // shiftedNewC = 0x0000000a00000000000000000000000000000000000000000000000000000000
            // clearedC    = 0x0001000000000000000000000000000f00000000000000000000000000000016
            // newVal      = 0x0001000a00000000000000000000000f00000000000000000000000000000016
            sstore(C.slot, newSlotValue)
        }
    }

    //0x0000000000000000000000000000000000000000000000000000000000000000
    //0x0064000700000000000000000000000f0000000000000000000000000000ffff

    function writeToB(uint16 newB) external {
        assembly {
            let slotValue := sload(B.slot)
            let clearedB := and(
                slotValue,
                0xffff0000fffffffffffffffffff0000ffffffffffffffffffffffffffffffff
            )
            //0x0064000700000000000000000000000f0000000000000000000000000000ffff
            let shiftedNewB := shl(mul(B.offset, 8), newB)
            let newSlotValue := or(shiftedNewB, clearedB)

            sstore(B.slot, newSlotValue)
        }
    }
}

contract FunctionExample {
    function factorial(uint256 n) public pure returns (uint256) {
        uint256 result;
        assembly {
            // Define the recursive factorial function
            function fact(x) -> y {
                switch x
                case 0 {
                    y := 1
                }
                default {
                    y := mul(x, fact(sub(x, 1)))
                }
            }
            // Call the factorial function with input n
            result := fact(n)
        }
        return result;
    }
}

contract LoopExample {
    function sum(uint256 n) public pure returns (uint256) {
        uint256 result;
        assembly {
            let i := 0
            for { } lt(i, n) { i := add(i, 1) } {
                result := add(result, i)
            }
        }
        return result;
    }
}


contract ControlFlowExample {
    function conditional(uint256 x) public pure returns (uint256) {
        uint256 result;
        assembly {
            // If x is less than 10
            if lt(x, 10) {
                // Set result to 1
                result := 1
            }
            // Else case, if x is not less than 10
            if iszero(lt(x, 10)) {
                // Set result to 2
                result := 2
            }
        }
        return result;
    }
}


contract StringHandlingExample {
    function getFirstCharacter(string memory input) public pure returns (bytes1) {
        bytes memory inputBytes = bytes(input); // Convert string to bytes array
        bytes1 firstChar;

        assembly {
            let inputPtr := add(inputBytes, 0x20) // Pointer to the first character in the bytes array
            firstChar := mload(inputPtr)           // Load the first character byte
        }

        return firstChar;
    }
}


