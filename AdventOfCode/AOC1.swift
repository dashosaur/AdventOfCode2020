//  AOC1.swift
//  AdventOfCode
//
//  Created by Dash on 11/29/20.
//

import Foundation

struct AOC1: AOC {
    func solve1(input: String) -> Int {
        for x in input.integers {
            for y in input.integers {
                if x + y == 2020 {
                    return x * y
                }
            }
        }
        return 0
    }
    
    func solve2(input: String) -> Int {
        for x in input.integers {
            for y in input.integers {
                for z in input.integers {
                    if x + y + z == 2020 {
                        return x * y * z
                    }
                }
            }
        }
        return 0
    }
}
