// The Swift Programming Language
// https://docs.swift.org/swift-book

import BigInt

public enum MathStorage {
    case int(Int)
    case double(Double)
    case bigInt(BigInt)
    case bigDecimal(BigInt, scale: Int)
}

public struct Math: Equatable, Comparable, ExpressibleByIntegerLiteral, ExpressibleByFloatLiteral, ExpressibleByStringLiteral {
    private var storage: MathStorage
    
    // MARK: - Init
    public init(integerLiteral value: Int) {
        self.storage = .int(value)
    }
    
    public init(floatLiteral value: Double) {
        if value.isFinite {
            self.storage = .double(value)
        } else {
            self.storage = .double(0)
        }
    }
    
    public init(stringLiteral value: String) {
        if let intVal = Int(value) {
            self.storage = .int(intVal)
        } else if let dblVal = Double(value) {
            self.storage = .double(dblVal)
        } else if value.contains(".") {
            let parts = value.split(separator: ".")
            let scale = parts[1].count
            let combined = parts.joined()
            self.storage = .bigDecimal(BigInt(combined) ?? BigInt(0), scale: scale)
        } else {
            self.storage = .bigInt(BigInt(value) ?? BigInt(0))
        }
    }
    
    private func asBigDecimal() -> (BigInt, Int) {
        switch storage {
        case .int(let v): return (BigInt(v), 0)
        case .double(let v):
            let str = String(v)
            if let dot = str.firstIndex(of: ".") {
                let decimals = str.distance(from: dot, to: str.endIndex) - 1
                let cleaned = str.replacingOccurrences(of: ".", with: "")
                return (BigInt(cleaned) ?? BigInt(0), decimals)
            } else {
                return (BigInt(Int(v)), 0)
            }
        case .bigInt(let v): return (v, 0)
        case .bigDecimal(let v, let scale): return (v, scale)
        }
    }
    
    private func align(_ other: Math) -> (BigInt, BigInt, Int) {
        let (lv, ls) = self.asBigDecimal()
        let (rv, rs) = other.asBigDecimal()
        
        if ls == rs {
            return (lv, rv, ls)
        } else if ls > rs {
            let factor = BigInt(10).power(ls - rs)
            return (lv, rv * factor, ls)
        } else {
            let factor = BigInt(10).power(rs - ls)
            return (lv * factor, rv, rs)
        }
    }
    
    public static func == (lhs: Math, rhs: Math) -> Bool {
        let (lv, rv, _) = lhs.align(rhs)
        return lv == rv
    }
    
    public static func < (lhs: Math, rhs: Math) -> Bool {
        let (lv, rv, _) = lhs.align(rhs)
        return lv < rv
    }
}

public extension Math {
    static func + (lhs: Math, rhs: Math) -> Math {
        let (lv, rv, scale) = lhs.align(rhs)
        return .init(bigDecimal: lv + rv, scale: scale)
    }
    
    static func - (lhs: Math, rhs: Math) -> Math {
        let (lv, rv, scale) = lhs.align(rhs)
        return .init(bigDecimal: lv - rv, scale: scale)
    }
    
    static func * (lhs: Math, rhs: Math) -> Math {
        let (lv, ls) = lhs.asBigDecimal()
        let (rv, rs) = rhs.asBigDecimal()
        return .init(bigDecimal: lv * rv, scale: ls + rs)
    }
    
    static func / (lhs: Math, rhs: Math) -> Math {
        let (lv, ls) = lhs.asBigDecimal()
        let (rv, rs) = rhs.asBigDecimal()
        
        // scale result up for precision
        let scale = max(ls, rs) + 10 // keep 10 decimal digits
        let factor = BigInt(10).power(scale)
        
        let quotient = (lv * factor) / rv
        return .init(bigDecimal: quotient, scale: scale)
    }
    
    static func % (lhs: Math, rhs: Math) -> Math {
        let (lv, rv, scale) = lhs.align(rhs)
        return .init(bigDecimal: lv % rv, scale: scale)
    }
    
    // Convenience initializer
    init(bigDecimal value: BigInt, scale: Int) {
        if scale == 0 {
            self.storage = .bigInt(value)
        } else {
            self.storage = .bigDecimal(value, scale: scale)
        }
    }
}

precedencegroup ExponentiationPrecedence {
    higherThan: MultiplicationPrecedence
    associativity: right
}

precedencegroup TetrationPrecedence {
    higherThan: ExponentiationPrecedence
    associativity: right
}

precedencegroup PentationPrecedence {
    higherThan: TetrationPrecedence
    associativity: right
}

precedencegroup HexationPrecedence {
    higherThan: PentationPrecedence
    associativity: right
}

precedencegroup HeptationPrecedence {
    higherThan: HexationPrecedence
    associativity: right
}

precedencegroup OctationPrecedence {
    higherThan: HeptationPrecedence
    associativity: right
}

precedencegroup NonationPrecedence {
    higherThan: OctationPrecedence
    associativity: right
}

precedencegroup DekationPrecedence {
    higherThan: NonationPrecedence
    associativity: right
}

infix operator **: ExponentiationPrecedence
infix operator ^^: TetrationPrecedence
infix operator ^^^: PentationPrecedence
infix operator ^^^^: HexationPrecedence
infix operator ^^^^^: HeptationPrecedence
infix operator ^^^^^^: OctationPrecedence
infix operator ^^^^^^^: NonationPrecedence
infix operator ^^^^^^^^: DekationPrecedence

public extension Math {
    private static func hyper(_ a: Math, _ b: Math, level: Int) -> Math {
        let n: Int
        switch b.storage {
        case .int(let v): n = v
        case .bigInt(let v): n = Int(v)
        case .double(let v): n = Int(v)
        case .bigDecimal(let v, _): n = Int(v)
        }
        guard n > 0 else { return Math(integerLiteral: 1) }
        
        switch level {
        case 2: // exponentiation
            if n == 1 { return a }
            return a ** (hyper(a, Math(integerLiteral: n - 1), level: 2))
        case 3: // tetration
            if n == 1 { return a }
            return a ** (hyper(a, Math(integerLiteral: n - 1), level: 3))
        case 4: // pentation
            if n == 1 { return a }
            return hyper(a, hyper(a, Math(integerLiteral: n - 1), level: 3), level: 3)
        case 5: // hexation
            if n == 1 { return a }
            return hyper(a, hyper(a, Math(integerLiteral: n - 1), level: 4), level: 4)
        case 6: // heptation
            if n == 1 { return a }
            return hyper(a, hyper(a, Math(integerLiteral: n - 1), level: 5), level: 5)
        case 7: // octation
            if n == 1 { return a }
            return hyper(a, hyper(a, Math(integerLiteral: n - 1), level: 6), level: 6)
        case 8: // nonation
            if n == 1 { return a }
            return hyper(a, hyper(a, Math(integerLiteral: n - 1), level: 7), level: 7)
        case 9: // dekation
            if n == 1 { return a }
            return hyper(a, hyper(a, Math(integerLiteral: n - 1), level: 8), level: 8)
        default:
            return Math(integerLiteral: 0) // fallback or unsupported level
        }
    }
    
    static func ** (lhs: Math, rhs: Math) -> Math {
        let (lv, rv, scale) = lhs.align(rhs)
        return .init(bigDecimal: lv.power(Int(rv)), scale: scale)
    }
    
    static func ^^ (lhs: Math, rhs: Math) -> Math {
        return hyper(lhs, rhs, level: 3)
    }
    
    static func ^^^ (lhs: Math, rhs: Math) -> Math {
        return hyper(lhs, rhs, level: 4)
    }
    
    static func ^^^^ (lhs: Math, rhs: Math) -> Math {
        return hyper(lhs, rhs, level: 5)
    }
    
    static func ^^^^^ (lhs: Math, rhs: Math) -> Math {
        return hyper(lhs, rhs, level: 6)
    }
    
    static func ^^^^^^ (lhs: Math, rhs: Math) -> Math {
        return hyper(lhs, rhs, level: 7)
    }
    
    static func ^^^^^^^ (lhs: Math, rhs: Math) -> Math {
        return hyper(lhs, rhs, level: 8)
    }
    
    static func ^^^^^^^^ (lhs: Math, rhs: Math) -> Math {
        return hyper(lhs, rhs, level: 9)
    }
}
