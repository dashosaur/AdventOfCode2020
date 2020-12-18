//  AOC3.swift
//  AdventOfCode
//
//  Created by Dash on 12/2/20.
//

import Foundation

struct AOC3: Puzzle {
    struct TreeMap {
        private let lines: [String]
        
        init(input: String) {
            lines = input.lines
        }
        
        func hasTree(at point: (Int, Int)) -> Bool {
            lines[point.1][point.0 % lines[0].count] == "#"
        }
        
        func treeCountUsingSlope(_ slope: (Int, Int)) -> Int {
            var currentPoint = (0, 0)
            var treeCount = 0
            while currentPoint.1 < lines.count {
                treeCount += hasTree(at: currentPoint) ? 1 : 0
                currentPoint = currentPoint + slope
            }
            return treeCount
        }
    }
    
    func solve1(input: String) -> Int {
        TreeMap(input: input).treeCountUsingSlope((3, 1))
    }
    
    func solve2(input: String) -> Int {
        let treeMap = TreeMap(input: input)
        let slopes = [(1, 1), (3, 1), (5, 1), (7, 1), (1, 2)]
        return slopes.reduceProduct { treeMap.treeCountUsingSlope($0) }
    }
}
fileprivate extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}
