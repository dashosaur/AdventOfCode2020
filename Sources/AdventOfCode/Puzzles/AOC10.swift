//  AOC10.swift
//  AdventOfCode
//
//  Created by Dash on 12/8/20.
//

import Foundation

struct AOC10: Puzzle {
    func parseAdapters(from input: String) -> [Int] {
        let adaptersInBag = input.integers.sorted()
        guard let maxInBag = adaptersInBag.last else { fatalError() }
        return [0] + adaptersInBag + [maxInBag + 3]
    }
    
    func countArrangements(ofSortedAdapters adapters: [Int], maxJoltDiff: Int, cachedCountsByAdapter: inout [Int: Int]) -> Int {
        guard let first = adapters.first, adapters.count > 1 else {
            return 1
        }
        if let cachedTotal = cachedCountsByAdapter[first] {
            return cachedTotal
        }
        var total = 0
        for diff in 1...maxJoltDiff {
            if let next = adapters[safe: diff], next - first <= maxJoltDiff {
                total += countArrangements(ofSortedAdapters: Array(adapters[diff...]), maxJoltDiff: maxJoltDiff, cachedCountsByAdapter: &cachedCountsByAdapter)
            }
        }
        cachedCountsByAdapter[first] = total
        return total
    }
    
    func solve1(input: String) -> Int {
        let adapters = parseAdapters(from: input)
        let joltDiffs = zip(adapters.dropFirst(), adapters).map(-)
        let set = joltDiffs.reduce(into: NSCountedSet(), { $0.add($1) })
        return set.count(for: 1) * set.count(for: 3)
    }
    
    func solve2(input: String) -> Int {
        let adapters = parseAdapters(from: input)
        var cachedCountsByAdapter: [Int : Int] = [:]
        return countArrangements(ofSortedAdapters: adapters, maxJoltDiff: 3, cachedCountsByAdapter: &cachedCountsByAdapter)
    }
}
