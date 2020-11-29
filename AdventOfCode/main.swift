//  main.swift
//  AdventOfCode
//
//  Created by Dash on 11/29/20.
//

import Foundation

protocol AOC {
    func solve() -> Int
}

let currentPuzzle = AOC1()

let startDate = Date()
print("🚀 Started \(String(describing: currentPuzzle.self).trimmingCharacters(in: CharacterSet(charactersIn: "()")))\n")
print("Solution: \(currentPuzzle.solve())")
print("\n⏱ Finished in \(Int(Date().timeIntervalSince(startDate) * 1000))ms")
