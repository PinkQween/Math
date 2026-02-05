 # Randomness
 
 Math includes seedable random generators for reproducible results.
 
 ## Overview
 
 - ``Random``: fast xorshift-based generator (good for games and simulations).
 - ``RandomSHA256``: SHA-256 counter-mode generator (stable, deterministic).
 - ``RandomChaCha20``: ChaCha20-based generator (higher quality).
 
 ## Examples
 
 ```swift
 var rng = Random(seed: 42)
 let r1 = rng.nextMath()           // 0.0 <= r1 < 1.0
 let r2 = rng.nextMath(in: 1...6)  // dice roll
 ```
 
 ```swift
 var secureRng = RandomChaCha20(seed: 123)
 let v = secureRng.nextMath(in: 0..<100)
 ```
 
 ## Notes
 
 All public APIs return ``Math`` values. The RNGs are deterministic for a fixed seed.
 
