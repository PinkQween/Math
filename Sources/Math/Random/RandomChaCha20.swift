//
//  RandomChaCha20.swift
//  Math
//
//  ChaCha20-based RNG.
//

public struct RandomChaCha20: Sendable {
    private var key: [UInt32]
    private var nonce: [UInt32]
    private var counter: UInt32
    private var buffer: [UInt8]
    private var index: Int

    public init(seed: Math) {
        var sm = SplitMix64(seed: RandomChaCha20.seedValue(seed))
        self.key = [
            UInt32(truncatingIfNeeded: sm.next()),
            UInt32(truncatingIfNeeded: sm.next()),
            UInt32(truncatingIfNeeded: sm.next()),
            UInt32(truncatingIfNeeded: sm.next()),
            UInt32(truncatingIfNeeded: sm.next()),
            UInt32(truncatingIfNeeded: sm.next()),
            UInt32(truncatingIfNeeded: sm.next()),
            UInt32(truncatingIfNeeded: sm.next())
        ]
        self.nonce = [
            UInt32(truncatingIfNeeded: sm.next()),
            UInt32(truncatingIfNeeded: sm.next()),
            UInt32(truncatingIfNeeded: sm.next())
        ]
        self.counter = 1
        self.buffer = []
        self.index = 0
        refill()
    }

    public init(seed: (Math, Math)) {
        var sm = SplitMix64(seed: RandomChaCha20.seedValue(seed.0))
        var sm2 = SplitMix64(seed: RandomChaCha20.seedValue(seed.1))
        self.key = [
            UInt32(truncatingIfNeeded: sm.next()),
            UInt32(truncatingIfNeeded: sm.next()),
            UInt32(truncatingIfNeeded: sm.next()),
            UInt32(truncatingIfNeeded: sm.next()),
            UInt32(truncatingIfNeeded: sm2.next()),
            UInt32(truncatingIfNeeded: sm2.next()),
            UInt32(truncatingIfNeeded: sm2.next()),
            UInt32(truncatingIfNeeded: sm2.next())
        ]
        self.nonce = [
            UInt32(truncatingIfNeeded: sm.next()),
            UInt32(truncatingIfNeeded: sm2.next()),
            UInt32(truncatingIfNeeded: sm.next() ^ sm2.next())
        ]
        self.counter = 1
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
        var state: [UInt32] = [
            0x61707865, 0x3320646e, 0x79622d32, 0x6b206574,
            key[0], key[1], key[2], key[3],
            key[4], key[5], key[6], key[7],
            counter, nonce[0], nonce[1], nonce[2]
        ]
        let original = state
        for _ in 0..<10 {
            quarterRound(&state, 0, 4, 8, 12)
            quarterRound(&state, 1, 5, 9, 13)
            quarterRound(&state, 2, 6, 10, 14)
            quarterRound(&state, 3, 7, 11, 15)
            quarterRound(&state, 0, 5, 10, 15)
            quarterRound(&state, 1, 6, 11, 12)
            quarterRound(&state, 2, 7, 8, 13)
            quarterRound(&state, 3, 4, 9, 14)
        }
        for i in 0..<16 { state[i] &+= original[i] }

        var out: [UInt8] = []
        out.reserveCapacity(64)
        for w in state {
            out.append(UInt8(w & 0xff))
            out.append(UInt8((w >> 8) & 0xff))
            out.append(UInt8((w >> 16) & 0xff))
            out.append(UInt8((w >> 24) & 0xff))
        }
        buffer = out
        index = 0
        counter &+= 1
    }

    private mutating func quarterRound(_ state: inout [UInt32], _ a: Int, _ b: Int, _ c: Int, _ d: Int) {
        state[a] &+= state[b]; state[d] ^= state[a]; state[d] = (state[d] << 16) | (state[d] >> 16)
        state[c] &+= state[d]; state[b] ^= state[c]; state[b] = (state[b] << 12) | (state[b] >> 20)
        state[a] &+= state[b]; state[d] ^= state[a]; state[d] = (state[d] << 8) | (state[d] >> 24)
        state[c] &+= state[d]; state[b] ^= state[c]; state[b] = (state[b] << 7) | (state[b] >> 25)
    }

    private static func seedValue(_ value: Math) -> UInt64 {
        if let i = value.asInt { return UInt64(bitPattern: Int64(i)) }
        if let d = value.asDouble { return UInt64(d) }
        return 0
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
