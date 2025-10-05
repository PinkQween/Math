//
//  Register.swift
//  Math
//
//  Sequential logic components: latches, flip-flops, and registers
//

/// An SR (Set-Reset) latch.
///
/// A basic memory element that can store one bit.
/// - S=1, R=0: Set (Q=1)
/// - S=0, R=1: Reset (Q=0)
/// - S=0, R=0: Hold current value
/// - S=1, R=1: Invalid/undefined state
public class SRLatch: LogicGate {
    public let set: Wire
    public let reset: Wire
    public let q: Wire
    public let qBar: Wire

    private let nor1: NORGate
    private let nor2: NORGate

    public init(set: Wire, reset: Wire, q: Wire, qBar: Wire) {
        self.set = set
        self.reset = reset
        self.q = q
        self.qBar = qBar

        // Cross-coupled NOR gates
        self.nor1 = NORGate(inputA: set, inputB: qBar, output: q)
        self.nor2 = NORGate(inputA: reset, inputB: q, output: qBar)

        // Initialize to a known state
        q.setSignal(.low)
        qBar.setSignal(.high)
    }

    public func update() {
        // Update multiple times to allow feedback to stabilize
        for _ in 0..<4 {
            nor1.update()
            nor2.update()
        }
    }
}

/// A D latch (Data latch).
///
/// Stores the value of D when enable is high.
/// - Enable=1: Q follows D
/// - Enable=0: Q holds its value
public class DLatch: LogicGate {
    public let data: Wire
    public let enable: Wire
    public let q: Wire
    public let qBar: Wire

    private let notGate: NOTGate
    private let and1: ANDGate
    private let and2: ANDGate
    private let srLatch: SRLatch

    private let dataBar: Wire
    private let setWire: Wire
    private let resetWire: Wire

    public init(data: Wire, enable: Wire, q: Wire, qBar: Wire) {
        self.data = data
        self.enable = enable
        self.q = q
        self.qBar = qBar

        // Internal wires
        self.dataBar = Wire(name: "data_bar")
        self.setWire = Wire(name: "set")
        self.resetWire = Wire(name: "reset")

        // NOT gate for inverted data
        self.notGate = NOTGate(input: data, output: dataBar)

        // AND gates to gate the data with enable
        self.and1 = ANDGate(inputA: data, inputB: enable, output: setWire)
        self.and2 = ANDGate(inputA: dataBar, inputB: enable, output: resetWire)

        // SR latch for storage
        self.srLatch = SRLatch(set: setWire, reset: resetWire, q: q, qBar: qBar)
    }

    public func update() {
        notGate.update()
        and1.update()
        and2.update()
        srLatch.update()
    }
}

/// A D flip-flop (edge-triggered).
///
/// Captures the value of D on the rising edge of the clock.
/// This is a simplified model that triggers on clock transitions.
public class DFlipFlop: LogicGate {
    public let data: Wire
    public let clock: Wire
    public let q: Wire
    public let qBar: Wire

    private var lastClock: Signal = .low
    private var storedValue: Signal = .low

    public init(data: Wire, clock: Wire, q: Wire, qBar: Wire) {
        self.data = data
        self.clock = clock
        self.q = q
        self.qBar = qBar

        q.addDriver { [weak self] in
            self?.storedValue ?? .undefined
        }

        qBar.addDriver { [weak self] in
            self?.storedValue.inverted ?? .undefined
        }

        clock.addObserver { [weak self] _ in
            self?.update()
        }

        data.addObserver { [weak self] _ in
            self?.update()
        }

        // Initialize
        q.setSignal(.low)
        qBar.setSignal(.high)
    }

    public func update() {
        let currentClock = clock.signal

        // Detect rising edge (low to high transition)
        if lastClock == .low && currentClock == .high {
            // Capture data on rising edge
            storedValue = data.signal
        }

        lastClock = currentClock

        // Update outputs
        q.update()
        qBar.update()
    }
}

/// A register (multiple D flip-flops).
///
/// Stores a multi-bit value on clock edges.
public class Register: LogicGate {
    public let data: Bus
    public let clock: Wire
    public let output: Bus

    private var flipFlops: [DFlipFlop] = []

    /// Creates a register of the specified width.
    ///
    /// - Parameters:
    ///   - width: The number of bits.
    ///   - name: The name prefix for wires.
    public init(width: Int, name: String = "reg") {
        let dataBus = Bus(width: width, name: "\(name)_d")
        let outputBus = Bus(width: width, name: "\(name)_q")
        let clockWire = Wire(name: "\(name)_clk")

        self.data = dataBus
        self.clock = clockWire
        self.output = outputBus

        // Create a flip-flop for each bit
        for i in 0..<width {
            let qBar = Wire(name: "\(name)_qbar[\(i)]")
            let ff = DFlipFlop(
                data: dataBus.wires[i],
                clock: clockWire,
                q: outputBus.wires[i],
                qBar: qBar
            )
            flipFlops.append(ff)
        }
    }

    /// Creates a register with existing buses.
    public init(data: Bus, clock: Wire, output: Bus) {
        precondition(data.width == output.width, "Data and output buses must have same width")

        self.data = data
        self.clock = clock
        self.output = output

        // Create a flip-flop for each bit
        for i in 0..<data.width {
            let qBar = Wire(name: "qbar[\(i)]")
            let ff = DFlipFlop(
                data: data.wires[i],
                clock: clock,
                q: output.wires[i],
                qBar: qBar
            )
            flipFlops.append(ff)
        }
    }

    public func update() {
        for ff in flipFlops {
            ff.update()
        }
    }

    /// Loads a value into the register (sets data inputs and pulses clock).
    ///
    /// - Parameter value: The value to load.
    public func load(_ value: Int) {
        data.setValue(value)
        clock.setSignal(.low)
        update()
        clock.setSignal(.high)
        update()
        clock.setSignal(.low)
        update()
    }

    /// Gets the current value stored in the register.
    public var value: Int? {
        output.intValue
    }
}

/// A register with enable signal.
///
/// Only updates when enable is high.
public class EnabledRegister: LogicGate {
    public let data: Bus
    public let enable: Wire
    public let clock: Wire
    public let output: Bus

    private let register: Register
    private let muxes: [Multiplexer2to1]

    public init(width: Int, name: String = "en_reg") {
        let dataBus = Bus(width: width, name: "\(name)_d")
        let enableWire = Wire(name: "\(name)_en")
        let clockWire = Wire(name: "\(name)_clk")
        let outputBus = Bus(width: width, name: "\(name)_q")
        let muxOutBus = Bus(width: width, name: "\(name)_mux_out")

        self.data = dataBus
        self.enable = enableWire
        self.clock = clockWire
        self.output = outputBus

        // Register stores the value
        self.register = Register(data: muxOutBus, clock: clockWire, output: outputBus)

        // Muxes select between new data and current output
        self.muxes = (0..<width).map { i in
            Multiplexer2to1(
                inputA: outputBus.wires[i],  // Hold current value when enable=0
                inputB: dataBus.wires[i],    // Load new value when enable=1
                selector: enableWire,
                output: muxOutBus.wires[i]
            )
        }
    }

    public func update() {
        for mux in muxes {
            mux.update()
        }
        register.update()
    }

    /// Loads a value into the register if enable is high.
    public func load(_ value: Int, enabled: Bool = true) {
        data.setValue(value)
        enable.setSignal(Signal(enabled))
        update()
        clock.setSignal(.high)
        update()
        clock.setSignal(.low)
        update()
    }

    public var value: Int? {
        output.intValue
    }
}
