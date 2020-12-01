//  main.swift
//  AdventOfCode
//
//  Created by Dash on 11/29/20.
//

import Foundation

protocol AOC {
    func solve1(input: String) -> Int
    func solve2(input: String) -> Int
}

let currentPuzzle = AOC1()

let startDate = Date()
print("🚀 Started \(String(describing: type(of: currentPuzzle)))\n")
print("Solution: \(currentPuzzle.solve2(input: String.input))")
print("\n⏱ Finished in \(Int(Date().timeIntervalSince(startDate) * 1000))ms")
