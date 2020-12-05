//  AOC5.swift
//  AdventOfCode
//
//  Created by Dash on 12/4/20.
//

import Foundation

struct AOC5: Puzzle {
    func solve1(input: String) -> Int {
        input.lines.reduceMaximum { $0.seatID }
    }
    
    func solve2(input: String) -> Int {
        IndexSet(indexes: input.lines.map { $0.seatID }).rangeView.last!.first! - 1
    }
}

extension String {
    private var binaryString: String {
        reduce("", { $0 + (["F":"0", "B":"1", "L":"0", "R":"1"][$1] ?? "") })
    }
    
    var seatID: Int {
        Int(binaryString, radix: 2)!
    }
}
