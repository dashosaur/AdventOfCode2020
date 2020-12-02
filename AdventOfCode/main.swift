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

let currentPuzzle = AOC2()

print("\n🚀 Running \(String(describing: type(of: currentPuzzle)))\n")

let startDate1 = Date()
print("Part 1 Solution: \(currentPuzzle.solve1(input: String.input)) | ⏱ \(startDate1.milisecondsAgo)ms\n")

let startDate2 = Date()
print("Part 2 Solution: \(currentPuzzle.solve2(input: String.input)) | ⏱ \(startDate2.milisecondsAgo)ms\n")

extension Date {
    var milisecondsAgo: Int {
        Int(Date().timeIntervalSince(self) * 1000)
    }
}
