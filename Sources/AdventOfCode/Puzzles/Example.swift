//  AOCExample.swift
//  AdventOfCode
//
//  Created by Dash on 11/30/20.
//

import Foundation

struct Example: Puzzle {
    func solve1(input: String) -> Int {
        input.integers
            .map { $0 / 3 - 2 }
            .reduce(0, +)
    }
    
    func solve2(input: String) -> Int {
        func calculateFuel(_ value: Int) -> Int {
            if value <= 0 { return 0 }
            var fuel = value / 3 - 2
            fuel += calculateFuel(fuel)
            return max(fuel, 0)
        }
        
        return input.integers
            .map { calculateFuel($0) }
            .reduce(0, +)
    }
}
