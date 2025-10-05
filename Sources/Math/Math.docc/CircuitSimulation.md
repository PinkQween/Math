# Circuit Simulation

Build and simulate digital circuits from transistors to ALUs.

## Overview

The Circuit module provides a complete digital circuit simulator that allows you to build circuits from basic transistors up to complex components like registers and arithmetic logic units (ALUs). The simulator uses an event-driven model with signal propagation through wires and components.

## Signal Representation

Circuits use four-valued logic to represent signal states:

- **Low (0)**: Logic low/ground
- **High (1)**: Logic high/VDD
- **High-Z**: High impedance/floating/disconnected
- **Undefined**: Unknown or conflicting state

### Wire and Bus

Wires carry individual signals, while buses group multiple wires for multi-bit values:

```swift
// Single wire
let wire = Wire(name: "signal", initialSignal: .low)
wire.setSignal(.high)
print(wire.signal)  // .high

// Bus (multi-bit)
let bus = Bus(width: 8, name: "data")
bus.setValue(42)
print(bus.intValue)  // 42
```

## Transistor-Level Components

### MOSFET Transistors

Build circuits from NMOS and PMOS transistors:

```swift
// NMOS: conducts when gate is HIGH
let nmos = NMOSTransistor(gate: gateWire, source: groundWire, drain: outWire)

// PMOS: conducts when gate is LOW
let pmos = PMOSTransistor(gate: gateWire, source: vddWire, drain: outWire)
```

### CMOS Inverter

A complementary inverter using both NMOS and PMOS:

```swift
let input = Wire(name: "in")
let output = Wire(name: "out")
let inverter = CMOSInverter(input: input, output: output)

input.setSignal(.high)
inverter.update()
print(output.signal)  // .low
```

## Logic Gates

### Basic Gates

Pre-built logic gates for common operations:

```swift
let a = Wire(name: "a", initialSignal: .high)
let b = Wire(name: "b", initialSignal: .low)
let out = Wire(name: "out")

// AND gate
let andGate = ANDGate(inputA: a, inputB: b, output: out)
andGate.update()
print(out.signal)  // .low

// OR, NAND, NOR, XOR gates work similarly
```

Available gates:
- ``ANDGate``
- ``ORGate``
- ``NANDGate``
- ``NORGate``
- ``XORGate``
- ``NOTGate``
- ``Multiplexer2to1``

### Arithmetic Components

Build adders for arithmetic operations:

```swift
// Half adder: adds two bits
let ha = HalfAdder(inputA: a, inputB: b, sum: sum, carry: carry)

// Full adder: adds three bits (A + B + carryIn)
let fa = FullAdder(inputA: a, inputB: b, carryIn: cin, sum: sum, carryOut: cout)

// Ripple-carry adder: n-bit addition
let adder = RippleCarryAdder(
    inputA: busA,
    inputB: busB,
    carryIn: carryIn,
    sum: sumBus,
    carryOut: carryOut
)
```

## Sequential Logic

### Latches and Flip-Flops

Memory elements that store state:

```swift
// SR Latch: Set-Reset latch
let srLatch = SRLatch(set: setWire, reset: resetWire, q: q, qBar: qBar)

// D Latch: Data latch (level-triggered)
let dLatch = DLatch(data: dataWire, enable: enableWire, q: q, qBar: qBar)

// D Flip-Flop: Edge-triggered storage
let dff = DFlipFlop(data: dataWire, clock: clockWire, q: q, qBar: qBar)
```

### Registers

Multi-bit storage elements:

```swift
// 8-bit register
let reg = Register(width: 8, name: "reg")

// Load value on clock edge
reg.load(42)
print(reg.value)  // 42

// Register with enable signal
let enabledReg = EnabledRegister(width: 8, name: "en_reg")
enabledReg.load(100, enabled: true)
```

## Arithmetic Logic Unit (ALU)

A complete ALU with multiple operations and status flags:

```swift
// Create 8-bit ALU
let alu = ALU(width: 8, name: "alu")

// Perform addition
alu.inputA.setValue(15)
alu.inputB.setValue(3)
alu.setOperation(.add)
alu.update()

print(alu.output.intValue)  // 18
print(alu.zero.signal)      // .low (result is not zero)
print(alu.carry.signal)     // .low (no overflow)
print(alu.overflow.signal)  // .low (no signed overflow)
print(alu.negative.signal)  // .low (result is positive)
```

### ALU Operations

The ALU supports 8 operations:

- **ADD**: A + B
- **SUB**: A - B (using two's complement)
- **AND**: A AND B (bitwise)
- **OR**: A OR B (bitwise)
- **XOR**: A XOR B (bitwise)
- **NOT**: NOT A (bitwise complement)
- **SHL**: Shift A left by 1
- **SHR**: Shift A right by 1

### ALU Status Flags

Four status flags provide information about the result:

- **Zero**: Set when result is all zeros
- **Carry**: Unsigned overflow (carry out from MSB)
- **Overflow**: Signed overflow (sign bit incorrect)
- **Negative**: Set when MSB is 1 (negative in two's complement)

```swift
// Detect overflow
alu.inputA.setValue(127)  // Max positive for signed 8-bit
alu.inputB.setValue(1)
alu.setOperation(.add)
alu.update()

print(alu.overflow.signal)  // .high (127 + 1 = -128, overflow!)
```

## Circuit Simulation

### CircuitSimulator

Manage and simulate complete circuits:

```swift
let sim = CircuitSimulator()

// Build circuit
let input = Wire(name: "in")
let output = Wire(name: "out")
let inv = NOTGate(input: input, output: output)

sim.addWire(input)
sim.addWire(output)
sim.addComponent(inv)

// Set inputs
input.setSignal(.high)

// Run simulation until stable
sim.step()

// Check result
print(output.signal)  // .low
```

### TestBench

Automated testing for circuits:

```swift
let bench = TestBench()

// Add test cases
bench.addTest(name: "Inverter test") {
    input.setSignal(.high)
} verify: {
    output.signal == .low
}

// Run all tests
let (passed, failed) = bench.runTests()
print("Passed: \(passed), Failed: \(failed)")
```

## Advanced Example: 4-bit Counter

Build a complete 4-bit counter with registers and an adder:

```swift
// Create components
let clock = Wire(name: "clock")
let count = Bus(width: 4, name: "count")
let next = Bus(width: 4, name: "next")
let one = Bus(width: 4, name: "one")

// Counter register
let counter = Register(data: next, clock: clock, output: count)

// Adder: count + 1
let carryIn = Wire(name: "cin", initialSignal: .low)
let carryOut = Wire(name: "cout")
let adder = RippleCarryAdder(
    inputA: count,
    inputB: one,
    carryIn: carryIn,
    sum: next,
    carryOut: carryOut
)

// Set constant 1
one.setValue(1)

// Clock the counter
for i in 0..<10 {
    adder.update()
    clock.setSignal(.low)
    counter.update()
    clock.setSignal(.high)
    counter.update()
    print("Count: \(count.intValue ?? 0)")
}
// Output: 0, 1, 2, 3, 4, 5, 6, 7, 8, 9
```

## Performance Considerations

The simulator uses an iterative stabilization algorithm with a configurable maximum iteration limit:

```swift
let sim = CircuitSimulator()
sim.maxIterations = 100  // Default

// Returns true if circuit stabilized, false if hit max iterations
let stable = sim.step()
if !stable {
    print("Warning: Circuit did not stabilize")
}
```

For large circuits or circuits with feedback loops, you may need to increase the iteration limit or redesign to avoid combinational loops.

## See Also

- ``Signal``
- ``Wire``
- ``Bus``
- ``LogicGate``
- ``ALU``
- ``Register``
- ``CircuitSimulator``
