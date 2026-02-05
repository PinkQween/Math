//
//  Random.swift
//  Math
//
//  Created by Hanna Skairipa on 2/4/26.
//

public struct Random: Sendable {
    public var state0: UInt64
    public var state1: UInt64

    public init(seed: Math) {
        var sm = SplitMix64(seed: Random.seedValue(seed))
        self.state0 = sm.next()
        self.state1 = sm.next()
        if state0 == 0 && state1 == 0 {
            self.state1 = 0x9E3779B97F4A7C15
        }
    }

    public init(seed: (Math, Math)) {
        self.state0 = Random.seedValue(seed.0)
        self.state1 = Random.seedValue(seed.1)
        if state0 == 0 && state1 == 0 {
            self.state1 = 0x9E3779B97F4A7C15
        }
    }
}

public extension Random {
    mutating func nextMath() -> Math {
        // 53-bit precision fraction
        let value = nextUInt64() >> 11
        let dbl = Double(value) * (1.0 / 9007199254740992.0)
        return Math(floatLiteral: dbl)
    }

    mutating func nextMath(in range: Range<Int>) -> Math {
        precondition(!range.isEmpty, "Range must not be empty")
        let span = UInt64(range.upperBound - range.lowerBound)
        let value = nextUInt64() % span
        return Math(integerLiteral: range.lowerBound + Int(value))
    }

    mutating func nextMath(in range: ClosedRange<Int>) -> Math {
        precondition(range.lowerBound <= range.upperBound, "Range must be valid")
        let span = UInt64(range.upperBound - range.lowerBound + 1)
        let value = nextUInt64() % span
        return Math(integerLiteral: range.lowerBound + Int(value))
    }

    mutating func nextMath(in range: Range<Math>) -> Math {
        let start = range.lowerBound.asDouble ?? 0
        let end = range.upperBound.asDouble ?? start
        precondition(end > start, "Range must be increasing")
        let t = Double(nextMath())
        return Math(floatLiteral: start + (end - start) * t)
    }

    mutating func nextMath(in range: ClosedRange<Math>) -> Math {
        let start = range.lowerBound.asDouble ?? 0
        let end = range.upperBound.asDouble ?? start
        precondition(end >= start, "Range must be valid")
        let t = Double(nextMath())
        return Math(floatLiteral: start + (end - start) * t)
    }

    mutating func nextBool() -> Bool {
        (nextUInt64() & 1) == 1
    }

    mutating func nextMathInt(in range: Range<Math>) -> Math {
        let lower = range.lowerBound.asInt ?? 0
        let upper = range.upperBound.asInt ?? lower
        precondition(upper > lower, "Range must be increasing")
        let value = nextMath(in: lower..<upper)
        return value
    }

    mutating func nextMathInt(in range: ClosedRange<Math>) -> Math {
        let lower = range.lowerBound.asInt ?? 0
        let upper = range.upperBound.asInt ?? lower
        precondition(upper >= lower, "Range must be valid")
        let value = nextMath(in: lower...upper)
        return value
    }
}

private struct SplitMix64 {
    private var state: UInt64

    init(seed: UInt64) {
        self.state = seed
    }

    mutating func next() -> UInt64 {
        state &+= 0x9E3779B97F4A7C15
        var z = state
        z = (z ^ (z >> 30)) &* 0xBF58476D1CE4E5B9
        z = (z ^ (z >> 27)) &* 0x94D049BB133111EB
        return z ^ (z >> 31)
    }
}

private extension Random {
    static func seedValue(_ value: Math) -> UInt64 {
        if let i = value.asInt { return UInt64(bitPattern: Int64(i)) }
        if let d = value.asDouble { return UInt64(d) }
        return 0
    }
}
