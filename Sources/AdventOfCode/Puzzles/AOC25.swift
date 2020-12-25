//  AOC25.swift
//  AdventOfCode
//
//  Created by Dash on 12/24/20.
//

import Foundation

struct AOC25: Puzzle {
    func transformValue(_ value: Int, subject: Int) -> Int {
        (value * subject) % 20201227
    }
    
    func loopSize(publicKey: Int) -> Int {
        var value = 1
        var loopSize = 0
        while value != publicKey {
            loopSize += 1
            value = transformValue(value, subject: 7)
        }
        return loopSize
    }
    
    func loop(size: Int, subject: Int) -> Int {
        (1...size).reduce(1) { value, _ in transformValue(value, subject: subject) }
    }
    
    func solve1(input: String) -> Int {
        let devices = input.integers.map({ (publicKey: $0, loopSize: loopSize(publicKey: $0)) }).sorted(by: { $1.loopSize > $0.loopSize })
        return loop(size: devices[0].loopSize, subject: devices[1].publicKey)
    }
    
    func solve2(input: String) -> Int {
        return 0
    }
}
