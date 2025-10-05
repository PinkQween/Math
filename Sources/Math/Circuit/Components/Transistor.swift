//
//  Transistor.swift
//  Math
//
//  MOSFET transistor models for circuit simulation
//

/// A MOSFET (Metal-Oxide-Semiconductor Field-Effect Transistor).
///
/// Transistors are the fundamental building blocks of digital circuits.
/// They act as voltage-controlled switches.
public protocol Transistor: AnyObject {
    /// The gate terminal (control input).
    var gate: Wire { get }

    /// The source terminal.
    var source: Wire { get }

    /// The drain terminal.
    var drain: Wire { get }

    /// Updates the transistor state based on gate voltage.
    func update()
}

/// An NMOS (N-channel MOSFET) transistor.
///
/// NMOS transistors conduct when the gate is HIGH:
/// - Gate = HIGH (1): Source and Drain are connected
/// - Gate = LOW (0): Source and Drain are disconnected (high-Z)
///
/// ### Example Usage
/// ```swift
/// let gate = Wire(name: "gate")
/// let source = Wire(name: "source", initialSignal: .low)
/// let drain = Wire(name: "drain")
///
/// let nmos = NMOSTransistor(gate: gate, source: source, drain: drain)
///
/// gate.setSignal(.high)  // Turn on transistor
/// nmos.update()          // Drain now connected to source
/// ```
public class NMOSTransistor: Transistor {
    public let gate: Wire
    public let source: Wire
    public let drain: Wire

    /// Creates an NMOS transistor.
    ///
    /// - Parameters:
    ///   - gate: The gate terminal.
    ///   - source: The source terminal (typically connected to ground for NMOS).
    ///   - drain: The drain terminal.
    public init(gate: Wire, source: Wire, drain: Wire) {
        self.gate = gate
        self.source = source
        self.drain = drain

        // Add driver to drain based on transistor state
        drain.addDriver { [weak self] in
            guard let self = self else { return .undefined }
            return self.computeOutput()
        }

        // Observe gate changes to trigger updates
        gate.addObserver { [weak self] _ in
            self?.update()
        }

        // Observe source changes to propagate to drain
        source.addObserver { [weak self] _ in
            self?.update()
        }
    }

    private func computeOutput() -> Signal {
        // NMOS conducts when gate is high
        switch gate.signal {
        case .high:
            // Transistor ON: drain follows source
            return source.signal
        case .low:
            // Transistor OFF: drain is high-Z
            return .highZ
        case .highZ, .undefined:
            return .undefined
        }
    }

    public func update() {
        drain.update()
    }
}

/// A PMOS (P-channel MOSFET) transistor.
///
/// PMOS transistors conduct when the gate is LOW:
/// - Gate = LOW (0): Source and Drain are connected
/// - Gate = HIGH (1): Source and Drain are disconnected (high-Z)
///
/// PMOS transistors are typically used with source connected to VDD (power).
///
/// ### Example Usage
/// ```swift
/// let gate = Wire(name: "gate")
/// let source = Wire(name: "source", initialSignal: .high) // VDD
/// let drain = Wire(name: "drain")
///
/// let pmos = PMOSTransistor(gate: gate, source: source, drain: drain)
///
/// gate.setSignal(.low)   // Turn on transistor
/// pmos.update()          // Drain now connected to source (VDD)
/// ```
public class PMOSTransistor: Transistor {
    public let gate: Wire
    public let source: Wire
    public let drain: Wire

    /// Creates a PMOS transistor.
    ///
    /// - Parameters:
    ///   - gate: The gate terminal.
    ///   - source: The source terminal (typically connected to VDD for PMOS).
    ///   - drain: The drain terminal.
    public init(gate: Wire, source: Wire, drain: Wire) {
        self.gate = gate
        self.source = source
        self.drain = drain

        // Add driver to drain based on transistor state
        drain.addDriver { [weak self] in
            guard let self = self else { return .undefined }
            return self.computeOutput()
        }

        // Observe gate changes to trigger updates
        gate.addObserver { [weak self] _ in
            self?.update()
        }

        // Observe source changes to propagate to drain
        source.addObserver { [weak self] _ in
            self?.update()
        }
    }

    private func computeOutput() -> Signal {
        // PMOS conducts when gate is low
        switch gate.signal {
        case .low:
            // Transistor ON: drain follows source
            return source.signal
        case .high:
            // Transistor OFF: drain is high-Z
            return .highZ
        case .highZ, .undefined:
            return .undefined
        }
    }

    public func update() {
        drain.update()
    }
}

/// A CMOS inverter built from NMOS and PMOS transistors.
///
/// This is the fundamental building block of CMOS logic.
/// It uses complementary NMOS and PMOS transistors to create
/// a low-power inverter with rail-to-rail output.
///
/// ### Circuit Structure
/// ```
/// VDD (power)
///  |
///  |-- [PMOS] --
///  |            |
/// Input ------->+--- Output
///  |            |
///  |-- [NMOS] --
///  |
/// GND (ground)
/// ```
public class CMOSInverter {
    public let input: Wire
    public let output: Wire
    private let vdd: Wire
    private let gnd: Wire
    private let pmos: PMOSTransistor
    private let nmos: NMOSTransistor

    /// Creates a CMOS inverter.
    ///
    /// - Parameters:
    ///   - input: The input wire.
    ///   - output: The output wire.
    ///   - vdd: The power supply wire (default: HIGH).
    ///   - gnd: The ground wire (default: LOW).
    public init(input: Wire, output: Wire, vdd: Wire? = nil, gnd: Wire? = nil) {
        self.input = input
        self.output = output
        self.vdd = vdd ?? Wire(name: "VDD", initialSignal: .high)
        self.gnd = gnd ?? Wire(name: "GND", initialSignal: .low)

        // PMOS: source=VDD, gate=input, drain=output
        self.pmos = PMOSTransistor(gate: input, source: self.vdd, drain: output)

        // NMOS: drain=output, gate=input, source=GND
        self.nmos = NMOSTransistor(gate: input, source: self.gnd, drain: output)
    }

    /// Updates the inverter output.
    public func update() {
        pmos.update()
        nmos.update()
    }
}
