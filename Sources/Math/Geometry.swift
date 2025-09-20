//
//  Geometry.swift
//  Math
//
//  Created by Hanna Skairipa on 9/19/25.
//

import Foundation

struct Triangle {
    var a: Double? // side opposite alpha
    var b: Double?
    var c: Double?
    var alpha: Double? // angle in degrees
    var beta: Double?
    var gamma: Double?

    // MARK: - Helper functions
    private func deg2rad(_ deg: Double) -> Double {
        return deg * .pi / 180
    }
    
    private func rad2deg(_ rad: Double) -> Double {
        return rad * 180 / .pi
    }
    
    // MARK: - Solve Triangle
    mutating func solve() throws {
        // Count how many sides and angles we know
        let knownSides = [a, b, c].compactMap { $0 }.count
        let knownAngles = [alpha, beta, gamma].compactMap { $0 }.count
        
        guard knownSides + knownAngles >= 3 else {
            throw NSError(domain: "TriangleSolver", code: 1, userInfo: [NSLocalizedDescriptionKey: "At least 3 pieces of info required."])
        }
        
        // 1️⃣ If 2 angles are known, compute the third
        if let alpha = alpha, let beta = beta, gamma == nil {
            gamma = 180 - alpha - beta
        } else if let alpha = alpha, let gamma = gamma, beta == nil {
            beta = 180 - alpha - gamma
        } else if let beta = beta, let gamma = gamma, alpha == nil {
            alpha = 180 - beta - gamma
        }
        
        // 2️⃣ Solve using Law of Sines if we know one side and its opposite angle
        if let a = a, let alpha = alpha {
            if let beta = beta, b == nil {
                b = a * sin(deg2rad(beta)) / sin(deg2rad(alpha))
            }
            if let gamma = gamma, c == nil {
                c = a * sin(deg2rad(gamma)) / sin(deg2rad(alpha))
            }
        }
        if let b = b, let beta = beta {
            if let alpha = alpha, a == nil {
                a = b * sin(deg2rad(alpha)) / sin(deg2rad(beta))
            }
            if let gamma = gamma, c == nil {
                c = b * sin(deg2rad(gamma)) / sin(deg2rad(beta))
            }
        }
        if let c = c, let gamma = gamma {
            if let alpha = alpha, a == nil {
                a = c * sin(deg2rad(alpha)) / sin(deg2rad(gamma))
            }
            if let beta = beta, b == nil {
                b = c * sin(deg2rad(beta)) / sin(deg2rad(gamma))
            }
        }
        
        // 3️⃣ Solve using Law of Cosines for remaining sides
        if let a = a, let b = b, let gamma = gamma, c == nil {
            c = sqrt(a*a + b*b - 2*a*b*cos(deg2rad(gamma)))
        }
        if let a = a, let c = c, let beta = beta, b == nil {
            b = sqrt(a*a + c*c - 2*a*c*cos(deg2rad(beta)))
        }
        if let b = b, let c = c, let alpha = alpha, a == nil {
            a = sqrt(b*b + c*c - 2*b*c*cos(deg2rad(alpha)))
        }
        
        // 4️⃣ Solve angles with Law of Cosines if needed
        if let a = a, let b = b, let c = c {
            if alpha == nil {
                alpha = rad2deg(acos((b*b + c*c - a*a)/(2*b*c)))
            }
            if beta == nil {
                beta = rad2deg(acos((a*a + c*c - b*b)/(2*a*c)))
            }
            if gamma == nil {
                gamma = 180 - (alpha ?? 0) - (beta ?? 0)
            }
        }
    }
    
    // Optional: compute perimeter
    func perimeter() -> Double? {
        guard let a = a, let b = b, let c = c else { return nil }
        return a + b + c
    }
    
    // Optional: compute area using Heron's formula
    func area() -> Double? {
        guard let a = a, let b = b, let c = c else { return nil }
        let s = (a + b + c) / 2
        return sqrt(s * (s - a) * (s - b) * (s - c))
    }
}
