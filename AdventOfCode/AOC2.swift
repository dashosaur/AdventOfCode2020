//  AOC2.swift
//  AdventOfCode
//
//  Created by Dash on 12/1/20.
//

import Foundation

struct AOC2: AOC {
    
    /// Enforces a password policy of the provided `character` being used a number of times within the provided `countRange`
    struct CountRangePolicy {
        let countRange: ClosedRange<Int>
        let character: Character
        
        func acceptsPassword(_ password: String) -> Bool {
            countRange.contains(password.count(of: character))
        }
    }
    
    func solve1(input: String) -> Int {
        input.lines.count { line -> Bool in
            let parsedValues = line.parse()
            let policy = CountRangePolicy(countRange: parsedValues.int1...parsedValues.int2, character: parsedValues.character)
            return policy.acceptsPassword(parsedValues.password)
        }
    }
    
    /// Enforces a password policy of the provided `character` being at exactly one of the provided string `indexes`
    struct SingleIndexPolicy {
        let indexes: Set<Int>
        let character: Character
        
        func acceptsPassword(_ password: String) -> Bool {
            indexes.count(passing: { password[$0] == character }) == 1
        }
    }
    
    func solve2(input: String) -> Int {
        input.lines.count { line -> Bool in
            let parsedValues = line.parse()
            let policy = SingleIndexPolicy(indexes: [parsedValues.int1 - 1, parsedValues.int2 - 1], character: parsedValues.character)
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
