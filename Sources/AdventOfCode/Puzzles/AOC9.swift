//  AOC9.swift
//  AdventOfCode
//
//  Created by Dash on 12/8/20.
//

import Foundation

struct AOC9: Puzzle {
    func firstInvalidNumber(in numbers: [Int], bufferSize: Int) -> Int {
        var numberBuffer: [Int] = []
        for sumTarget in numbers {
            guard numberBuffer.count == bufferSize else {
                numberBuffer.append(sumTarget)
                continue
            }
            let bufferSet = Set(numberBuffer)
            if !bufferSet.contains(where: { $0 != (sumTarget - $0) && bufferSet.contains(sumTarget - $0) }) {
                return sumTarget
            }
            numberBuffer.append(sumTarget)
            numberBuffer.removeFirst()
        }
        fatalError("No solution")
    }
    
    func solve1(input: String) -> Int {
        firstInvalidNumber(in: input.integers, bufferSize: 25)
    }
    
    func minMaxOfSubrangeWithSum(_ sumTarget: Int, in numbers: [Int]) -> (min: Int, max: Int) {
        for (startIndex, startNumber) in numbers.enumerated() {
            var stats = (min: startNumber, max: startNumber, sum: startNumber)
            for nextNumber in numbers.suffix(numbers.count - startIndex - 1) {
                stats.min = min(stats.min, nextNumber)
                stats.max = max(stats.max, nextNumber)
                stats.sum += nextNumber
                if stats.sum == sumTarget {
                    return (stats.min, stats.max)
                }
            }
        }
        fatalError("No solution")
    }
    
    func solve2(input: String) -> Int {
        let numbers = input.integers
        let sumTarget = firstInvalidNumber(in: numbers, bufferSize: 25)
        let minMax = minMaxOfSubrangeWithSum(sumTarget, in: numbers)
        return minMax.min + minMax.max
    }
}
