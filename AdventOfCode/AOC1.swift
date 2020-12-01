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
            for (_, y) in integers.suffix(from: xi + 1).enumerated() {
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
            for (yi, y) in integers.suffix(from: xi + 1).enumerated() {
                for (_, z) in integers.suffix(from: yi + 1).enumerated() {
                    if [x, y, z].reduce(0, +) == 2020 {
                        return [x, y, z].reduce(1, *)
                    }
                }
            }
        }
        fatalError("No solution")
    }
}
