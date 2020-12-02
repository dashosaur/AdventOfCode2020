//  String.swift
//  AdventOfCode
//
//  Created by Dash on 12/2/20.
//

import Foundation

// MARK: - String Splitting

extension String {
    func components(seperatedByCharactersIn characterSetString: String) -> [String] {
        components(separatedBy: CharacterSet(charactersIn: characterSetString)).filter { $0 != "" }
    }
    
    var componentStrings: [String] {
        components(seperatedByCharactersIn: ", \n").filter { $0 != "" }
    }
    
    var lines: [String] {
        components(seperatedByCharactersIn: "\n").filter { $0 != "" }
    }
}

// MARK: - Value Parsing

extension String {
    var integers: [Int] {
        componentStrings.map { string in
            if let value = Int(string) { return value }
            fatalError("Cannot convert \(string) to Int")
        }
    }
    
    var doubles: [Double] {
        componentStrings.map { string in
            if let value = Double(string) { return value }
            fatalError("Cannot convert \(string) to Double")
        }
    }
    
    var points: [CGPoint] {
        lines.map { string in
            let items = string.components(seperatedByCharactersIn: ", ")
            guard items.count == 2 else {
                fatalError("Cannot convert \(string) to CGPoint, count = \(items.count)")
            }
            guard let x = Double(items[0]), let y = Double(items[1]) else {
                fatalError("Cannot convert \(string) to CGPoint, items = \(items)")
            }
            return CGPoint(x: x, y: y)
        }
    }
}

// MARK: - Characters

extension String {
    func count(of character: Character) -> Int {
        reduce(0, { $0 + ($1 == character ? 1 : 0) })
    }
}

extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}
