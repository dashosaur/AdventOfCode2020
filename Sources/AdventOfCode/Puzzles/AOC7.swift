//  AOC7.swift
//  AdventOfCode
//
//  Created by Dash on 12/6/20.
//

import Foundation

fileprivate struct RuleSet {
    struct Rule {
        let outerColor: String
        let contentsCountByColor: [String : Int]
        
        init(ruleLine: String) {
            let sanitized = ruleLine.replacingOccurrences(of: " bags", with: "").replacingOccurrences(of: " bag", with: "").replacingOccurrences(of: ".", with: "")
            let split = sanitized.components(separatedBy: " contain ")
            outerColor = split[0]
            contentsCountByColor = split[1].components(separatedBy: ", ").reduce(into: [:], {
                if let countAndColor = $1.scanCountAndColor() {
                    $0[countAndColor.1] = countAndColor.0
                }
            })
        }
    }
    
    let rulesByColor: [String : Rule]
    
    init(input: String) {
        rulesByColor = input.lines.reduce(into: [String : Rule](), {
            let rule = Rule(ruleLine: $1)
            $0[rule.outerColor] = rule
        })
    }
    
    func canColor(_ outerColor: String, containColor innerColor: String) -> Bool {
        rulesByColor[outerColor]!.contentsCountByColor.contains(where: { $0.key == innerColor || canColor($0.key, containColor: innerColor) })
    }
    
    func countInside(color: String) -> Int {
        rulesByColor[color]!.contentsCountByColor.reduceSum({ $0.value * (1 + countInside(color: $0.key)) })
    }
}

fileprivate extension String {
    static let shinyGold: String = "shiny gold"
    
    func scanCountAndColor() -> (Int, String)? {
        let scanner = Scanner(string: self)
        if let int = scanner.scanInt() {
            let color = scanner.scanCharacters(from: CharacterSet.letters.union(CharacterSet.whitespaces))!
            return (int, color)
        } else {
            return nil
        }
    }
}

struct AOC7: Puzzle {
    /// Returns the count of bag colors that can contain a shiny gold bag
    func solve1(input: String) -> Int {
        let ruleSet = RuleSet(input: input)
        return ruleSet.rulesByColor.keys.count(passing: { ruleSet.canColor($0, containColor: .shinyGold) })
    }
    
    /// Returns the count contained within a shiny gold bag
    func solve2(input: String) -> Int {
        RuleSet(input: input).countInside(color: .shinyGold)
    }
}
