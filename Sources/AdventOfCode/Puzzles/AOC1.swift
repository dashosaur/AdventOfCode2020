//  AOC1.swift
//  AdventOfCode
//
//  Created by Dash on 11/29/20.
//

import Foundation

struct AOC1: Puzzle {
    func solve1(input: String) -> Int {
        let integers = input.integers
        for (xi, x) in integers.enumerated() {
            for y in integers[(xi + 1)...] {
                if [x, y].reduce(0, +) == 2020 {
                    return [x, y].reduce(1, *)
                }
            }
        }
        fatalError("No solution")
    }
    
    func solve2(input: String) -> Int {
        let integers = input.integers
        for (xi, x) in integers.enumerated() {
            for (yi, y) in integers[(xi + 1)...].enumerated() {
                for z in integers[(yi + 1)...] {
                    if [x, y, z].reduce(0, +) == 2020 {
                        return [x, y, z].reduce(1, *)
                    }
                }
            }
        }
        fatalError("No solution")
    }
}
