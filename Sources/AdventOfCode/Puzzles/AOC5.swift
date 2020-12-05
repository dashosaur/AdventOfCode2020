//  AOC5.swift
//  AdventOfCode
//
//  Created by Dash on 12/4/20.
//

import Foundation

struct AOC5: Puzzle {
    func solve1(input: String) -> Int {
        input.lines.reduceMaximum { seatID(fromBoardingPass: $0) }
    }
    
    func solve2(input: String) -> Int {
        IndexSet(indexes: input.lines.map { seatID(fromBoardingPass: $0) }).rangeView.last!.first! - 1
    }
    
    func seatID(fromBoardingPass boardingPass: String) -> Int {
        boardingPass.reversed().enumerated().reduceSum { (index, char) in (char == "B" || char == "R") ? 1 << index : 0 }
    }
}
