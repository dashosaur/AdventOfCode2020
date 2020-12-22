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
        6 : AOC6(),
        7 : AOC7(),
        8 : AOC8(),
        9 : AOC9(),
        10 : AOC10(),
        11 : AOC11(),
        12 : AOC12(),
        13 : AOC13(),
        14 : AOC14(),
        15 : AOC15(),
        16 : AOC16(),
        17 : AOC17(),
        18 : AOC18(),
        19 : AOC19(),
        20 : AOC20(),
        21 : AOC21(),
        22 : AOC22(),
    ]
    
    func puzzle(at index: Int) -> Puzzle? {
        puzzlesByIndex[index]
    }
    
    var supportedPuzzleIndexes: [Int] {
        Array(puzzlesByIndex.keys).sorted()
    }
}
