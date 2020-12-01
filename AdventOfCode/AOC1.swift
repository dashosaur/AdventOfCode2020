//  AOC1.swift
//  AdventOfCode
//
//  Created by Dash on 11/29/20.
//

import Foundation

struct AOC1: AOC {
    func solve1(input: String) -> Int {
        let integers = input.integers
        for (xi, x) in integers.enumerated() {
            for (yi, y) in integers.enumerated() {
                if yi == xi { continue }
                if x + y == 2020 {
                    return x * y
                }
            }
        }
        return 0
    }
    
    func solve2(input: String) -> Int {
        let integers = input.integers
        for (xi, x) in integers.enumerated() {
            for (yi, y) in integers.enumerated() {
                if yi == xi { continue }
                for (zi, z) in integers.enumerated() {
                    if zi == yi || zi == xi { continue }
                    if x + y + z == 2020 {
                        return x * y * z
                    }
                }
            }
        }
        return 0
    }
}
