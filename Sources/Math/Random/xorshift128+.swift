//
//  xorshift128+.swift
//  Math
//
//  Created by Hanna Skairipa on 2/4/26.
//

extension Random {
    mutating func xorshift128Plus() -> UInt64 {
        var x = state0
        let y = state1
        state0 = y
        x ^= x << 23
        x ^= x >> 17
        x ^= y ^ (y >> 26)
        state1 = x
        return x &+ y
    }

    mutating func nextUInt64() -> UInt64 {
        xorshift128Plus()
    }
}
