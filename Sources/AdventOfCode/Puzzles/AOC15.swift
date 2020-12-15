//  AOC15.swift
//  AdventOfCode
//
//  Created by Dash on 12/14/20.
//

import Foundation

struct AOC15: Puzzle {
    func solve(startingNumbers: [Int], turnCount: Int) -> Int {
        var lastSpoken: Int? = nil
        var pastTurnsByNumber: [Int: (last: Int, nextToLast: Int?)] = [:]
        
        var turn = 1
        while turn <= turnCount {
            let numberToSpeak: Int
            if turn <= startingNumbers.count {
                numberToSpeak = startingNumbers[turn - 1]
            } else if let lastSpoken = lastSpoken, let turns = pastTurnsByNumber[lastSpoken], let nextToLast = turns.nextToLast {
                numberToSpeak = turns.last - nextToLast
            } else {
                numberToSpeak = 0
            }
            
            pastTurnsByNumber[numberToSpeak] = (last: turn, nextToLast: pastTurnsByNumber[numberToSpeak]?.last)
            lastSpoken = numberToSpeak
            turn += 1
        }
        
        return lastSpoken!
    }
    
    func solve1(input: String) -> Int {
        solve(startingNumbers: input.integers, turnCount: 2020)
    }
    
    func solve2(input: String) -> Int {
        solve(startingNumbers: input.integers, turnCount: 30000000)
    }
}
