//  AOC1.swift
//  AdventOfCode
//
//  Created by Dash on 11/29/20.
//

import Foundation

struct AOC1: AOC {
    func solve1(input: String) -> Int {
        let integers = input.integers
        for xi in 0 ..< integers.count {
            for yi in (xi + 1) ..< integers.count {
                if let product = product(of: integers[xi], y: integers[yi], ifSumEquals: 2020) {
                    return product
                }
            }
        }
        return 0
    }
    
    func solve2(input: String) -> Int {
        let integers = input.integers
        for xi in 0 ..< integers.count {
            for yi in (xi + 1) ..< integers.count {
                for zi in (yi + 1) ..< integers.count {
                    if let product = product(of: integers[xi], y: integers[yi], z: integers[zi], ifSumEquals: 2020) {
                        return product
                    }
                }
            }
        }
        return 0
    }
    
    func product(of x: Int, y: Int, z: Int? = nil, ifSumEquals sum: Int) -> Int? {
        if x + y + (z ?? 0) == sum {
            return x * y * (z ?? 1)
        }
        return nil
    }
}
