//  AOC5.swift
//  AdventOfCode
//
//  Created by Dash on 12/4/20.
//

import Foundation

struct AOC5: Puzzle {
    func solve1(input: String) -> Int {
        input.lines.map { $0.seatID }.reduce(0, { $1 > $0 ? $1 : $0 })
    }
    
    func solve2(input: String) -> Int {
        let sortedIDs = input.lines.map { $0.seatID }.sorted()
        for (index, id) in sortedIDs.enumerated() {
            if index == 0 { continue }
            if id == sortedIDs[index - 1] + 2 {
                return id - 1
            }
        }
        fatalError()
    }
}

extension String {
    var binaryString: String {
        self.replacingOccurrences(of: "F", with: "0")
            .replacingOccurrences(of: "B", with: "1")
            .replacingOccurrences(of: "L", with: "0")
            .replacingOccurrences(of: "R", with: "1")
    }
    
    var seatID: Int {
        let scanner = Scanner(string: self)
        if let rowText = scanner.scanCharacters(from: CharacterSet(charactersIn: "FB")),
           let row = Int(rowText.binaryString, radix: 2),
           let seatText = scanner.scanCharacters(from: CharacterSet(charactersIn: "RL")),
           let seat = Int(seatText.binaryString, radix: 2) {
            return row * 8 + seat
        } else {
            fatalError()
        }
    }
}
