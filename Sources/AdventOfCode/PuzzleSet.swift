//  PuzzleSet.swift
//  AdventOfCode
//
//  Created by Dash on 12/2/20.
//

import Foundation

protocol Puzzle {
    func solve1(input: String) -> Int
    func solve2(input: String) -> Int
}

struct PuzzleSet {
    private let puzzlesByIndex: [Int : Puzzle] = [
        0 : Example(),
        1 : AOC1(),
        2 : AOC2(),
        3 : AOC3(),
        4 : AOC4(),
        5 : AOC5(),
    ]
    
    func puzzle(at index: Int) -> Puzzle? {
        puzzlesByIndex[index]
    }
    
    var supportedPuzzleIndexes: [Int] {
        Array(puzzlesByIndex.keys).sorted()
    }
}
