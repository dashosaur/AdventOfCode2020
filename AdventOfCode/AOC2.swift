//  AOC2.swift
//  AdventOfCode
//
//  Created by Dash on 12/1/20.
//

import Foundation

struct AOC2: AOC {
    struct CountRangePolicy {
        let minCount: Int
        let maxCount: Int
        let character: Character
        
        func acceptsPassword(_ password: String) -> Bool {
            let count = password.reduce(0, { $0 + ($1 == character ? 1 : 0) })
            return count >= minCount && count <= maxCount
        }
    }
    
    func solve1(input: String) -> Int {
        input.lines.reduce(0) { (total, line) -> Int in
            let parsedValues = line.parse()
            let policy = CountRangePolicy(minCount: parsedValues.int1, maxCount: parsedValues.int2, character: parsedValues.character)
            return total + (policy.acceptsPassword(parsedValues.password) ? 1 : 0)
        }
    }

    struct UniqueIndexPolicy {
        let index1: Int
        let index2: Int
        let character: Character
        
        func acceptsPassword(_ password: String) -> Bool {
            (password[index1] == character && password[index2] != character) || (password[index1] != character && password[index2] == character)
        }
    }
    
    func solve2(input: String) -> Int {
        input.lines.reduce(0) { (total, line) -> Int in
            let parsedValues = line.parse()
            let policy = UniqueIndexPolicy(index1: parsedValues.int1 - 1, index2: parsedValues.int2 - 1, character: parsedValues.character)
            return total + (policy.acceptsPassword(parsedValues.password) ? 1 : 0)
        }
    }

}

fileprivate extension String {
    /// Parses a string of format "n-m c: password"
    func parse() -> (int1: Int, int2: Int, character: Character, password: String) {
        let scanner = Scanner(string: self)
        let int1 = scanner.scanInt()!
        _ = scanner.scanString("-")
        let int2 = scanner.scanInt()!
        let character = scanner.scanCharacter()!
        _ = scanner.scanString(": ")
        let password = String(self[scanner.currentIndex...])
        return (int1, int2, character, password)
    }
}

extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}
