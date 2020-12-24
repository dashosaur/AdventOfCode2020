//  AOC18.swift
//  AdventOfCode
//
//  Created by Dash on 12/17/20.
//

import Foundation

fileprivate enum Operator: String, CustomStringConvertible {
    case add = "+"
    case multiply = "*"
    
    var description: String { rawValue }
    
    var applyTo: (Int, Int) -> Int {
        switch self {
        case .add:
            return (+)
        case .multiply:
            return (*)
        }
    }
}

struct AOC18: Puzzle {
    
    func solve1(input: String) -> Int {
        input.lines.reduceSum { evaluate($0, addFirst: false) }
    }
    
    func solve2(input: String) -> Int {
        input.lines.reduceSum { evaluate($0, addFirst: true) }
    }
    
    func evaluate(_ expressionText: String, addFirst: Bool, level: Int = 0) -> Int {
        print("\(repeatElement("    ", count: level).joined())\(expressionText)")
        
        var values: [Int] = []
        var ops: [Operator] = []
        
        let scanner = Scanner(string: expressionText)
        while !scanner.isAtEnd {
            if let _ = scanner.scanString(Operator.multiply.rawValue) {
                ops.append(Operator.multiply)
            } else if let _ = scanner.scanString(Operator.add.rawValue) {
                ops.append(Operator.add)
            } else if let value = scanner.scanInt() {
                values.append(value)
            } else if let paranthetical = scanner.scanParanthetical() {
                values.append(evaluate(paranthetical, addFirst: addFirst, level: level + 1))
            }
        }
        
        // Evaluate adds first if needed
        while addFirst, let plusIndex = ops.firstIndex(of: .add) {
            let lhs = values.remove(at: plusIndex)
            let rhs = values.remove(at: plusIndex)
            let op = ops.remove(at: plusIndex)
            values.insert(op.applyTo(lhs, rhs), at: plusIndex)
        }
        
        // Evaluate expression from left to right
        return ops.enumerated().reduce(values.first ?? 0) { $1.element.applyTo($0, values[$1.offset + 1]) }
    }
}

extension Scanner {
    func scanParanthetical() -> String? {
        // Create a temporary Scanner to peek at the next character :(
        let tempScanner = Scanner(string: String(string[currentIndex...]))
        guard let char = tempScanner.scanCharacter(), char == "(" else { return nil }
        _ = scanCharacter()
        
        var counter = 1
        var subexpression = ""
        while counter > 0, let char = scanCharacter() {
            subexpression += String(char)
            if char == ")" {
                counter -= 1
            } else if char == "(" {
                counter += 1
            }
        }
        subexpression.removeLast()
        return subexpression
    }
}
