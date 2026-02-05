//
//  RandomSHA256.swift
//  Math
//
//  SHA-256 based RNG (counter-mode).
//

public struct RandomSHA256: Sendable {
    private var seedBytes: [UInt8]
    private var counter: UInt64
    private var buffer: [UInt8]
    private var index: Int

    public init(seed: Math) {
        let s = RandomSHA256.seedBytes(from: seed)
        self.seedBytes = s
        self.counter = 0
        self.buffer = []
        self.index = 0
        refill()
    }

    public init(seed: (Math, Math)) {
        let a = RandomSHA256.seedBytes(from: seed.0)
        let b = RandomSHA256.seedBytes(from: seed.1)
        self.seedBytes = a + b
        self.counter = 0
        self.buffer = []
        self.index = 0
        refill()
    }

    public mutating func nextMath() -> Math {
        let value = nextUInt64() >> 11
        let dbl = Double(value) * (1.0 / 9007199254740992.0)
        return Math(floatLiteral: dbl)
    }

    public mutating func nextMath(in range: Range<Int>) -> Math {
        precondition(!range.isEmpty, "Range must not be empty")
        let span = UInt64(range.upperBound - range.lowerBound)
        let value = nextUInt64() % span
        return Math(integerLiteral: range.lowerBound + Int(value))
    }

    public mutating func nextMath(in range: ClosedRange<Int>) -> Math {
        precondition(range.lowerBound <= range.upperBound, "Range must be valid")
        let span = UInt64(range.upperBound - range.lowerBound + 1)
        let value = nextUInt64() % span
        return Math(integerLiteral: range.lowerBound + Int(value))
    }

    public mutating func nextMathInt(in range: Range<Math>) -> Math {
        let lower = range.lowerBound.asInt ?? 0
        let upper = range.upperBound.asInt ?? lower
        precondition(upper > lower, "Range must be increasing")
        return nextMath(in: lower..<upper)
    }

    public mutating func nextMathInt(in range: ClosedRange<Math>) -> Math {
        let lower = range.lowerBound.asInt ?? 0
        let upper = range.upperBound.asInt ?? lower
        precondition(upper >= lower, "Range must be valid")
        return nextMath(in: lower...upper)
    }

    public mutating func nextBool() -> Bool {
        (nextUInt64() & 1) == 1
    }

    private mutating func nextUInt64() -> UInt64 {
        if index + 8 > buffer.count {
            refill()
        }
        let v = (UInt64(buffer[index]) << 56) |
                (UInt64(buffer[index + 1]) << 48) |
                (UInt64(buffer[index + 2]) << 40) |
                (UInt64(buffer[index + 3]) << 32) |
                (UInt64(buffer[index + 4]) << 24) |
                (UInt64(buffer[index + 5]) << 16) |
                (UInt64(buffer[index + 6]) << 8) |
                (UInt64(buffer[index + 7]))
        index += 8
        return v
    }

    private mutating func refill() {
        var data = seedBytes
        let c = counter
        var cBytes: [UInt8] = []
        for i in (0..<8).reversed() {
            cBytes.append(UInt8((c >> (i * 8)) & 0xff))
        }
        data.append(contentsOf: cBytes)
        buffer = SHA256.hash(data)
        index = 0
        counter &+= 1
    }

    private static func seedBytes(from value: Math) -> [UInt8] {
        if let i = value.asInt {
            let v = UInt64(bitPattern: Int64(i))
            var out: [UInt8] = []
            for idx in (0..<8).reversed() {
                out.append(UInt8((v >> (idx * 8)) & 0xff))
            }
            return out
        }
        if let d = value.asDouble {
            let v = UInt64(d)
            var out: [UInt8] = []
            for idx in (0..<8).reversed() {
                out.append(UInt8((v >> (idx * 8)) & 0xff))
            }
            return out
        }
        return [0]
    }
}
