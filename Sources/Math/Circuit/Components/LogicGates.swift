//
//  LogicGates.swift
//  Math
//
//  Logic gate components for circuit simulation
//

/// A basic logic gate component.
public protocol LogicGate: AnyObject {
    /// Updates the gate's output based on its inputs.
    func update()
}

/// A NOT gate (inverter).
public class NOTGate: LogicGate {
    public let input: Wire
    public let output: Wire

    public init(input: Wire, output: Wire) {
        self.input = input
        self.output = output

        output.addDriver { [weak self] in
            self?.input.signal.inverted ?? .undefined
        }

        input.addObserver { [weak self] _ in
            self?.update()
        }
    }

    public func update() {
        output.update()
    }
}

/// An AND gate.
public class ANDGate: LogicGate {
    public let inputA: Wire
    public let inputB: Wire
    public let output: Wire

    public init(inputA: Wire, inputB: Wire, output: Wire) {
        self.inputA = inputA
        self.inputB = inputB
        self.output = output

        output.addDriver { [weak self] in
            guard let self = self else { return .undefined }
            return self.inputA.signal.and(self.inputB.signal)
        }

        inputA.addObserver { [weak self] _ in self?.update() }
        inputB.addObserver { [weak self] _ in self?.update() }
    }

    public func update() {
        output.update()
    }
}

/// An OR gate.
public class ORGate: LogicGate {
    public let inputA: Wire
    public let inputB: Wire
    public let output: Wire

    public init(inputA: Wire, inputB: Wire, output: Wire) {
        self.inputA = inputA
        self.inputB = inputB
        self.output = output

        output.addDriver { [weak self] in
            guard let self = self else { return .undefined }
            return self.inputA.signal.or(self.inputB.signal)
        }

        inputA.addObserver { [weak self] _ in self?.update() }
        inputB.addObserver { [weak self] _ in self?.update() }
    }

    public func update() {
        output.update()
    }
}

/// A NAND gate.
public class NANDGate: LogicGate {
    public let inputA: Wire
    public let inputB: Wire
    public let output: Wire
    private let andOutput: Wire
    private let andGate: ANDGate
    private let notGate: NOTGate

    public init(inputA: Wire, inputB: Wire, output: Wire) {
        self.inputA = inputA
        self.inputB = inputB
        self.output = output
        self.andOutput = Wire(name: "and_out")

        self.andGate = ANDGate(inputA: inputA, inputB: inputB, output: andOutput)
        self.notGate = NOTGate(input: andOutput, output: output)
    }

    public func update() {
        andGate.update()
        notGate.update()
    }
}

/// A NOR gate.
public class NORGate: LogicGate {
    public let inputA: Wire
    public let inputB: Wire
    public let output: Wire
    private let orOutput: Wire
    private let orGate: ORGate
    private let notGate: NOTGate

    public init(inputA: Wire, inputB: Wire, output: Wire) {
        self.inputA = inputA
        self.inputB = inputB
        self.output = output
        self.orOutput = Wire(name: "or_out")

        self.orGate = ORGate(inputA: inputA, inputB: inputB, output: orOutput)
        self.notGate = NOTGate(input: orOutput, output: output)
    }

    public func update() {
        orGate.update()
        notGate.update()
    }
}

/// An XOR gate.
public class XORGate: LogicGate {
    public let inputA: Wire
    public let inputB: Wire
    public let output: Wire

    public init(inputA: Wire, inputB: Wire, output: Wire) {
        self.inputA = inputA
        self.inputB = inputB
        self.output = output

        output.addDriver { [weak self] in
            guard let self = self else { return .undefined }
            return self.inputA.signal.xor(self.inputB.signal)
        }

        inputA.addObserver { [weak self] _ in self?.update() }
        inputB.addObserver { [weak self] _ in self?.update() }
    }

    public func update() {
        output.update()
    }
}

/// A multiplexer (2-to-1).
///
/// Selects between two inputs based on a selector signal.
/// - selector = 0: output = inputA
/// - selector = 1: output = inputB
public class Multiplexer2to1: LogicGate {
    public let inputA: Wire
    public let inputB: Wire
    public let selector: Wire
    public let output: Wire

    public init(inputA: Wire, inputB: Wire, selector: Wire, output: Wire) {
        self.inputA = inputA
        self.inputB = inputB
        self.selector = selector
        self.output = output

        output.addDriver { [weak self] in
            guard let self = self else { return .undefined }
            guard let sel = self.selector.signal.boolValue else { return .undefined }
            return sel ? self.inputB.signal : self.inputA.signal
        }

        inputA.addObserver { [weak self] _ in self?.update() }
        inputB.addObserver { [weak self] _ in self?.update() }
        selector.addObserver { [weak self] _ in self?.update() }
    }

    public func update() {
        output.update()
    }
}

/// A half adder adds two single bits and produces sum and carry.
///
/// Outputs:
/// - sum = A XOR B
/// - carry = A AND B
public class HalfAdder: LogicGate {
    public let inputA: Wire
    public let inputB: Wire
    public let sum: Wire
    public let carry: Wire

    private let xorGate: XORGate
    private let andGate: ANDGate

    public init(inputA: Wire, inputB: Wire, sum: Wire, carry: Wire) {
        self.inputA = inputA
        self.inputB = inputB
        self.sum = sum
        self.carry = carry

        self.xorGate = XORGate(inputA: inputA, inputB: inputB, output: sum)
        self.andGate = ANDGate(inputA: inputA, inputB: inputB, output: carry)
    }

    public func update() {
        xorGate.update()
        andGate.update()
    }
}

/// A full adder adds three single bits (A, B, carryIn) and produces sum and carryOut.
///
/// Outputs:
/// - sum = A XOR B XOR carryIn
/// - carryOut = (A AND B) OR (carryIn AND (A XOR B))
public class FullAdder: LogicGate {
    public let inputA: Wire
    public let inputB: Wire
    public let carryIn: Wire
    public let sum: Wire
    public let carryOut: Wire

    private let xor1: XORGate
    private let xor2: XORGate
    private let and1: ANDGate
    private let and2: ANDGate
    private let or1: ORGate

    private let xor1Out: Wire
    private let and1Out: Wire
    private let and2Out: Wire

    public init(inputA: Wire, inputB: Wire, carryIn: Wire, sum: Wire, carryOut: Wire) {
        self.inputA = inputA
        self.inputB = inputB
        self.carryIn = carryIn
        self.sum = sum
        self.carryOut = carryOut

        // Internal wires
        self.xor1Out = Wire(name: "xor1_out")
        self.and1Out = Wire(name: "and1_out")
        self.and2Out = Wire(name: "and2_out")

        // sum = A XOR B XOR Cin
        self.xor1 = XORGate(inputA: inputA, inputB: inputB, output: xor1Out)
        self.xor2 = XORGate(inputA: xor1Out, inputB: carryIn, output: sum)

        // carryOut = (A AND B) OR (Cin AND (A XOR B))
        self.and1 = ANDGate(inputA: inputA, inputB: inputB, output: and1Out)
        self.and2 = ANDGate(inputA: carryIn, inputB: xor1Out, output: and2Out)
        self.or1 = ORGate(inputA: and1Out, inputB: and2Out, output: carryOut)
    }

    public func update() {
        xor1.update()
        xor2.update()
        and1.update()
        and2.update()
        or1.update()
    }
}
