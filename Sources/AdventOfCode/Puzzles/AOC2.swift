//  AOC2.swift
//  AdventOfCode
//
//  Created by Dash on 12/1/20.
//

import Foundation

struct AOC2: Puzzle {
    enum Policy {
        /// Enforces a password policy of the provided `character` being used a number of times within the provided `countRange`
        case countInRange(countRange: ClosedRange<Int>, character: Character)
        
        /// Enforces a password policy of the provided `character` being at exactly one of the provided string `indexes`
        case singleIndex(indexes: Set<Int>, character: Character)
        
        func acceptsPassword(_ password: String) -> Bool {
            switch self {
            case .countInRange(let countRange, let character):
                return countRange.contains(password.count(of: character))
            case .singleIndex(let indexes, let character):
                return indexes.count(passing: { password[$0] == character }) == 1
            }
        }
    }
    
    func solve1(input: String) -> Int {
        input.lines.count { line -> Bool in
            let parsedValues = line.parse()
            let policy = Policy.countInRange(countRange: parsedValues.int1...parsedValues.int2, character: parsedValues.character)
            return policy.acceptsPassword(parsedValues.password)
        }
    }
    
    func solve2(input: String) -> Int {
        input.lines.count { line -> Bool in
            let parsedValues = line.parse()
            let policy = Policy.singleIndex(indexes: [parsedValues.int1 - 1, parsedValues.int2 - 1], character: parsedValues.character)
            return policy.acceptsPassword(parsedValues.password)
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
fileprivate extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}
