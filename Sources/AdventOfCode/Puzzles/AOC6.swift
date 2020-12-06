//  AOC6.swift
//  AdventOfCode
//
//  Created by Dash on 12/5/20.
//

import Foundation

struct AOC6: Puzzle {
    func solve1(input: String) -> Int {
        input.lineGroups.reduceSum { $0.filter({ !$0.isNewline }).reduce(into: Set(), { $0.insert($1) }).count }
    }
    
    func solve2(input: String) -> Int {
        input.lineGroups.reduceSum { $0.lines.reduce(Set($0.lines.first ?? "")) { $0.intersection(Set($1)) }.count }
    }
}
