//
//  CircuitSimulator.swift
//  Math
//
//  Circuit simulation engine
//

/// A circuit simulator that manages and evaluates digital circuits.
///
/// The simulator maintains a collection of components and wires,
/// and provides methods to step through simulation time and
/// propagate signals through the circuit.
///
/// ### Example Usage
/// ```swift
/// let sim = CircuitSimulator()
///
/// // Create circuit
/// let input = Wire(name: "in")
/// let output = Wire(name: "out")
/// let inv = NOTGate(input: input, output: output)
/// sim.addComponent(inv)
///
/// // Set inputs
/// input.setSignal(.high)
///
/// // Run simulation
/// sim.step()
///
/// // Check output
/// print(output.signal) // .low
/// ```
public class CircuitSimulator {
    /// All wires in the circuit.
    private var wires: [Wire] = []

    /// All components in the circuit.
    private var components: [LogicGate] = []

    /// Current simulation time (in arbitrary units).
    public private(set) var time: Int = 0

    /// Maximum number of iterations per step (to prevent infinite loops).
    public var maxIterations: Int = 100

    // MARK: - Initialization

    /// Creates a new circuit simulator.
    public init() {}

    // MARK: - Circuit Construction

    /// Adds a wire to the simulation.
    ///
    /// - Parameter wire: The wire to add.
    public func addWire(_ wire: Wire) {
        wires.append(wire)
    }

    /// Adds a component to the simulation.
    ///
    /// - Parameter component: The component to add.
    public func addComponent(_ component: LogicGate) {
        components.append(component)
    }

    /// Adds multiple wires to the simulation.
    ///
    /// - Parameter wires: The wires to add.
    public func addWires(_ wires: [Wire]) {
        self.wires.append(contentsOf: wires)
    }

    /// Adds multiple components to the simulation.
    ///
    /// - Parameter components: The components to add.
    public func addComponents(_ components: [LogicGate]) {
        self.components.append(contentsOf: components)
    }

    // MARK: - Simulation

    /// Advances the simulation by one time step.
    ///
    /// This evaluates all components and propagates signals until
    /// the circuit reaches a stable state or max iterations is reached.
    ///
    /// - Returns: True if the circuit stabilized, false if max iterations reached.
    @discardableResult
    public func step() -> Bool {
        time += 1

        var iteration = 0
        var stable = false

        while !stable && iteration < maxIterations {
            // Remember previous wire states
            let previousStates = wires.map { $0.signal }

            // Update all components
            for component in components {
                component.update()
            }

            // Check if circuit has stabilized
            stable = true
            for (index, wire) in wires.enumerated() {
                if wire.signal != previousStates[index] {
                    stable = false
                    break
                }
            }

            iteration += 1
        }

        return stable
    }

    /// Runs the simulation for multiple steps.
    ///
    /// - Parameter steps: The number of steps to run.
    /// - Returns: True if all steps stabilized, false if any didn't.
    @discardableResult
    public func run(steps: Int) -> Bool {
        var allStable = true
        for _ in 0..<steps {
            if !step() {
                allStable = false
            }
        }
        return allStable
    }

    /// Resets the simulation time.
    public func reset() {
        time = 0
    }

    /// Resets all wires to high-Z.
    public func resetWires() {
        for wire in wires {
            wire.setSignal(.highZ)
        }
    }

    // MARK: - Debugging

    /// Prints the current state of all wires.
    public func printWireStates() {
        print("=== Circuit State at t=\(time) ===")
        for wire in wires {
            print(wire)
        }
        print("===")
    }

    /// Gets a summary of the circuit.
    public var summary: String {
        """
        Circuit Summary:
        - Wires: \(wires.count)
        - Components: \(components.count)
        - Time: \(time)
        """
    }
}

/// A test bench for verifying circuit behavior.
///
/// Provides utilities for setting inputs, running the circuit,
/// and verifying outputs.
public class TestBench {
    public let simulator: CircuitSimulator

    /// Test cases: (name, inputs, expected outputs)
    private var testCases: [(name: String, setup: () -> Void, verify: () -> Bool)] = []

    public init() {
        self.simulator = CircuitSimulator()
    }

    /// Adds a test case.
    ///
    /// - Parameters:
    ///   - name: The test case name.
    ///   - setup: Closure to set up inputs.
    ///   - verify: Closure to verify outputs (returns true if passed).
    public func addTest(name: String, setup: @escaping () -> Void, verify: @escaping () -> Bool) {
        testCases.append((name, setup, verify))
    }

    /// Runs all test cases.
    ///
    /// - Returns: The number of passed tests.
    public func runTests() -> (passed: Int, failed: Int) {
        var passed = 0
        var failed = 0

        for test in testCases {
            // Reset circuit
            simulator.reset()
            simulator.resetWires()

            // Setup inputs
            test.setup()

            // Run simulation
            simulator.step()

            // Verify outputs
            if test.verify() {
                print("✓ \(test.name)")
                passed += 1
            } else {
                print("✗ \(test.name)")
                failed += 1
            }
        }

        print("\nResults: \(passed) passed, \(failed) failed")
        return (passed, failed)
    }
}
