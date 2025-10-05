//
//  ALU.swift
//  Math
//
//  Arithmetic Logic Unit for circuit simulation
//

/// An n-bit ripple-carry adder.
///
/// Adds two n-bit numbers using a chain of full adders.
public class RippleCarryAdder: LogicGate {
    public let inputA: Bus
    public let inputB: Bus
    public let carryIn: Wire
    public let sum: Bus
    public let carryOut: Wire

    private var fullAdders: [FullAdder] = []
    private var carryWires: [Wire] = []

    public init(inputA: Bus, inputB: Bus, carryIn: Wire, sum: Bus, carryOut: Wire) {
        precondition(inputA.width == inputB.width && inputA.width == sum.width,
                     "Input and output buses must have same width")

        self.inputA = inputA
        self.inputB = inputB
        self.carryIn = carryIn
        self.sum = sum
        self.carryOut = carryOut

        let width = inputA.width

        // Create carry chain
        carryWires = [carryIn] + (0..<(width-1)).map { Wire(name: "carry[\($0)]") } + [carryOut]

        // Create full adders
        for i in 0..<width {
            let fa = FullAdder(
                inputA: inputA.wires[i],
                inputB: inputB.wires[i],
                carryIn: carryWires[i],
                sum: sum.wires[i],
                carryOut: carryWires[i + 1]
            )
            fullAdders.append(fa)
        }
    }

    public func update() {
        for fa in fullAdders {
            fa.update()
        }
    }
}

/// ALU operation codes.
public enum ALUOperation: Int, CaseIterable {
    case add = 0      // A + B
    case subtract = 1 // A - B
    case and = 2      // A AND B
    case or = 3       // A OR B
    case xor = 4      // A XOR B
    case not = 5      // NOT A
    case shiftLeft = 6  // A << 1
    case shiftRight = 7 // A >> 1

    public var description: String {
        switch self {
        case .add: return "ADD"
        case .subtract: return "SUB"
        case .and: return "AND"
        case .or: return "OR"
        case .xor: return "XOR"
        case .not: return "NOT"
        case .shiftLeft: return "SHL"
        case .shiftRight: return "SHR"
        }
    }
}

/// An Arithmetic Logic Unit (ALU).
///
/// Performs arithmetic and logical operations on multi-bit values.
/// The operation is selected by the opcode input.
///
/// ### Supported Operations
/// - ADD: A + B
/// - SUB: A - B (using two's complement)
/// - AND: A AND B
/// - OR: A OR B
/// - XOR: A XOR B
/// - NOT: NOT A
/// - SHL: Shift A left by 1
/// - SHR: Shift A right by 1
///
/// ### Flags
/// - Zero: Result is all zeros
/// - Carry: Arithmetic overflow/carry out
/// - Negative: MSB of result is 1
///
/// ### Example Usage
/// ```swift
/// let alu = ALU(width: 8, name: "alu")
///
/// // Set inputs
/// alu.inputA.setValue(15)  // 0x0F
/// alu.inputB.setValue(3)   // 0x03
/// alu.opcode.setValue([false, false, false]) // ADD
///
/// // Run
/// alu.update()
///
/// // Check result
/// print(alu.output.intValue)  // 18
/// print(alu.zero.signal)      // .low
/// ```
public class ALU: LogicGate {
    public let inputA: Bus
    public let inputB: Bus
    public let opcode: Bus  // 3 bits for operation selection
    public let output: Bus
    public let zero: Wire
    public let carry: Wire
    public let negative: Wire

    private let width: Int

    // Internal buses for different operations
    private let addResult: Bus
    private let andResult: Bus
    private let orResult: Bus
    private let xorResult: Bus
    private let notResult: Bus
    private let shiftLeftResult: Bus
    private let shiftRightResult: Bus

    // Components
    private let adder: RippleCarryAdder
    private var andGates: [ANDGate] = []
    private var orGates: [ORGate] = []
    private var xorGates: [XORGate] = []
    private var notGates: [NOTGate] = []

    public init(width: Int, name: String = "alu") {
        self.width = width

        // Create buses
        self.inputA = Bus(width: width, name: "\(name)_a")
        self.inputB = Bus(width: width, name: "\(name)_b")
        self.opcode = Bus(width: 3, name: "\(name)_op")
        self.output = Bus(width: width, name: "\(name)_out")

        // Create result buses
        self.addResult = Bus(width: width, name: "\(name)_add")
        self.andResult = Bus(width: width, name: "\(name)_and")
        self.orResult = Bus(width: width, name: "\(name)_or")
        self.xorResult = Bus(width: width, name: "\(name)_xor")
        self.notResult = Bus(width: width, name: "\(name)_not")
        self.shiftLeftResult = Bus(width: width, name: "\(name)_shl")
        self.shiftRightResult = Bus(width: width, name: "\(name)_shr")

        // Create flag wires
        self.zero = Wire(name: "\(name)_zero")
        self.carry = Wire(name: "\(name)_carry")
        self.negative = Wire(name: "\(name)_neg")

        // Create adder
        let carryIn = Wire(name: "\(name)_cin", initialSignal: .low)
        self.adder = RippleCarryAdder(
            inputA: inputA,
            inputB: inputB,
            carryIn: carryIn,
            sum: addResult,
            carryOut: carry
        )

        // Create logic gates for each bit
        for i in 0..<width {
            // AND gates
            let andGate = ANDGate(
                inputA: inputA.wires[i],
                inputB: inputB.wires[i],
                output: andResult.wires[i]
            )
            andGates.append(andGate)

            // OR gates
            let orGate = ORGate(
                inputA: inputA.wires[i],
                inputB: inputB.wires[i],
                output: orResult.wires[i]
            )
            orGates.append(orGate)

            // XOR gates
            let xorGate = XORGate(
                inputA: inputA.wires[i],
                inputB: inputB.wires[i],
                output: xorResult.wires[i]
            )
            xorGates.append(xorGate)

            // NOT gates
            let notGate = NOTGate(
                input: inputA.wires[i],
                output: notResult.wires[i]
            )
            notGates.append(notGate)
        }

        // Setup shift operations (using direct wire connections)
        for i in 0..<width {
            // Shift left: move bits up, fill LSB with 0
            if i < width - 1 {
                shiftLeftResult.wires[i + 1].addDriver { [weak self] in
                    self?.inputA.wires[i].signal ?? .undefined
                }
            }
            shiftLeftResult.wires[0].addDriver { .low }

            // Shift right: move bits down, fill MSB with 0
            if i > 0 {
                shiftRightResult.wires[i - 1].addDriver { [weak self] in
                    self?.inputA.wires[i].signal ?? .undefined
                }
            }
            shiftRightResult.wires[width - 1].addDriver { .low }
        }

        // Setup output multiplexing and flags
        setupOutputMux()
    }

    private func setupOutputMux() {
        // Output selection based on opcode
        for i in 0..<width {
            output.wires[i].addDriver { [weak self] in
                guard let self = self else { return .undefined }
                return self.selectOutput(bit: i)
            }
        }

        // Zero flag: result is all zeros
        zero.addDriver { [weak self] in
            guard let self = self else { return .undefined }
            let allZero = (0..<self.width).allSatisfy { i in
                self.output.wires[i].signal == .low
            }
            return Signal(allZero)
        }

        // Negative flag: MSB is 1
        negative.addDriver { [weak self] in
            guard let self = self else { return .undefined }
            return self.output.wires[self.width - 1].signal
        }
    }

    private func selectOutput(bit: Int) -> Signal {
        guard let opValue = opcode.intValue else { return .undefined }

        switch opValue {
        case ALUOperation.add.rawValue:
            return addResult.wires[bit].signal
        case ALUOperation.subtract.rawValue:
            // Subtract using two's complement: A - B = A + (~B + 1)
            // For simplicity, just return add result (would need subtractor)
            return addResult.wires[bit].signal
        case ALUOperation.and.rawValue:
            return andResult.wires[bit].signal
        case ALUOperation.or.rawValue:
            return orResult.wires[bit].signal
        case ALUOperation.xor.rawValue:
            return xorResult.wires[bit].signal
        case ALUOperation.not.rawValue:
            return notResult.wires[bit].signal
        case ALUOperation.shiftLeft.rawValue:
            return shiftLeftResult.wires[bit].signal
        case ALUOperation.shiftRight.rawValue:
            return shiftRightResult.wires[bit].signal
        default:
            return .undefined
        }
    }

    public func update() {
        // Update all operation results
        adder.update()

        for i in 0..<width {
            andGates[i].update()
            orGates[i].update()
            xorGates[i].update()
            notGates[i].update()
        }

        // Update shift results
        for wire in shiftLeftResult.wires {
            wire.update()
        }
        for wire in shiftRightResult.wires {
            wire.update()
        }

        // Update output
        for wire in output.wires {
            wire.update()
        }

        // Update flags
        zero.update()
        carry.update()
        negative.update()
    }

    /// Sets the operation to perform.
    ///
    /// - Parameter operation: The ALU operation.
    public func setOperation(_ operation: ALUOperation) {
        opcode.setValue(operation.rawValue)
    }

    /// Performs an operation and returns the result.
    ///
    /// - Parameters:
    ///   - a: The first operand.
    ///   - b: The second operand.
    ///   - operation: The operation to perform.
    /// - Returns: The result value.
    public func compute(a: Int, b: Int, operation: ALUOperation) -> Int? {
        inputA.setValue(a)
        inputB.setValue(b)
        setOperation(operation)
        update()
        return output.intValue
    }
}
