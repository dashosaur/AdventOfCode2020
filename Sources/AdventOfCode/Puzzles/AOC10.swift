//  AOC10.swift
//  AdventOfCode
//
//  Created by Dash on 12/8/20.
//

import Foundation


var map: [Int : Int] = [:]

struct AOC10: Puzzle {
    func solve1(input: String) -> Int {
        var ints = input.integers
        ints.append(ints.max()! + 3)
        ints.sort()
        let set = NSCountedSet()
        var last = 0
        for i in ints {
            set.add(i - last)
            last = i
        }
        return set.count(for: 1) * set.count(for: 3)
    }
    
    func solCount(ints: [Int]) -> Int {
        if ints.count < 2 {
            return 1
        }
        if let i = ints.first, let m = map[i] {
            return m
        }
        var total = 0
        if ints[1] - ints[0] <= 3 {
            total += solCount(ints: Array(ints[1...]))
        }
        if ints.count >= 3 {
            if ints[2] - ints[0] <= 3 {
                total += solCount(ints: Array(ints[2...]))
            }
        }
        if ints.count >= 4 {
            if ints[3] - ints[0] <= 3 {
                total += solCount(ints: Array(ints[3...]))
            }
        }
        map[ints.first!] = total
        return total
    }
    
    func solve2(input: String) -> Int {
        var ints = input.integers
        ints.append(ints.max()! + 3)
        ints.append(0)
        ints.sort()
        print(ints)
        
        return solCount(ints: ints)
    }
}
