//  main.swift
//  AdventOfCode
//
//  Created by Dash on 11/29/20.
//

import Foundation

protocol AOC {
    func solve() -> Int
}

let startDate = Date()
print("▶️ Started\n")
print("Solution: \(AOC1().solve())")
print("\n⏹ Finished in \(Int(Date().timeIntervalSince(startDate) * 1000))ms")
