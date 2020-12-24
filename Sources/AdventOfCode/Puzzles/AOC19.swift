//  AOC19.swift
//  AdventOfCode
//
//  Created by Dash on 12/18/20.
//

import Foundation

fileprivate struct Check: Hashable {
    let id: Int
    let string: String
}

fileprivate struct Rule: CustomStringConvertible {
    let id: Int
    let options: Set<[Int]>
    let letter: String?
    
    var description: String {
        "\(id): \(options.map({$0.debugDescription}).joined(separator: " | "))\(letter != nil ? "\"\(letter!)\"" : "")"
    }
    
    func canMatch(_ string: String, rulesByID: [Int: Rule], checkResults: inout [Check: Bool]) -> Bool {
        let check = Check(id: id, string: string)
        if let checkResult = checkResults[Check(id: id, string: string)] { return checkResult }
        
        func canRules(_ rules: [Int], match string: String) -> Bool {
            if rules.count == 0 { return string.count == 0 }
            if rules.count > string.count { return false }
            
            for prefixCount in 1...string.count {
                let prefix = String(string.prefix(prefixCount))
                let remaining = String(string.dropFirst(prefixCount))
                if let firstID = rules.first, let firstRule = rulesByID[firstID] {
                    if firstRule.canMatch(prefix, rulesByID: rulesByID, checkResults: &checkResults),
                       canRules(Array(rules.dropFirst()), match: remaining) {
                        return true
                    }
                }
            }
            return false
        }
            
        if let letter = letter {
            return string == letter
        } else {
            for rules in options {
                if canRules(rules, match: string) {
                    checkResults[check] = true
                    return true
                }
            }
        }
        checkResults[check] = false
        return false
    }
}

struct AOC19: Puzzle {
    private func parseRulesByID(input: String) -> [Int: Rule] {
        input.lines.reduce(into: Dictionary(), { dictionary, line in
            let comp = line.components(separatedBy: ": ")
            let id = Int(comp[0])!
            let definition = comp[1]
            if definition.starts(with: "\"") {
                dictionary[id] = Rule(id: id, options: [], letter: definition.components(separatedBy: "\"")[1])
            } else {
                let options = definition.components(separatedBy: " | ").map { $0.integers }
                dictionary[id] = Rule(id: id, options: Set(options), letter: nil)
            }
        })
    }
    
    private func solve(input: String, ruleModification: (inout [Int: Rule]) -> Void = { _ in }) -> Int {
        var rulesByID = parseRulesByID(input: input.lineGroups[0])
        ruleModification(&rulesByID)
        
        for ruleID in rulesByID.keys.sorted() {
            print(rulesByID[ruleID]!)
        }
        
        let rule0 = rulesByID[0]!
        
        var checkResults: [Check: Bool] = [:]
        return input.lineGroups[1].lines.count(where: { rule0.canMatch($0, rulesByID: rulesByID, checkResults: &checkResults) })
    }
    
    func solve1(input: String) -> Int {
        solve(input: input)
    }
    
    func solve2(input: String) -> Int {
        solve(input: input) { rulesByID in
            rulesByID[8] = Rule(id: 8, options: Set([[42], [42, 8]]), letter: nil)
            rulesByID[11] = Rule(id: 11, options: Set([[42, 31], [42, 11, 31]]), letter: nil)
        }
    }
}
