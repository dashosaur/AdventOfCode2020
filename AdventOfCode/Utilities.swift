//  Utilities.swift
//  AdventOfCode
//
//  Created by Dash on 11/30/20.
//

import Foundation

extension CommandLine {
    static var filename: String? {
        if CommandLine.arguments.count >= 2 {
            return CommandLine.arguments[1]
        }
        return nil
    }
}

extension String {
    
    // MARK: - File
    
    static var input = String(contentsOfFileNamed: CommandLine.filename ?? "AdventOfCode/input.txt")
    
    private init(contentsOfFileNamed filename: String) {
        let url = URL(fileURLWithPath: FileManager.default.currentDirectoryPath).appendingPathComponent(filename)
        do {
            try self.init(contentsOf: url)
        } catch {
            fatalError("Could not load file: \(url.relativePath)")
        }
    }
    
    // MARK: - String Splitting
    
    func components(seperatedByCharactersIn characterSetString: String) -> [String] {
        components(separatedBy: CharacterSet(charactersIn: characterSetString)).filter { $0 != "" }
    }
    
    var componentStrings: [String] {
        components(seperatedByCharactersIn: ", \n").filter { $0 != "" }
    }
    
    var lines: [String] {
        components(seperatedByCharactersIn: "\n").filter { $0 != "" }
    }
    
    // MARK: - Value Parsing
    
    var integers: [Int] {
        componentStrings.map { string in
            if let value = Int(string) { return value }
            fatalError("failed to convert \(string) to Int")
        }
    }
    
    var doubles: [Double] {
        componentStrings.map { string in
            if let value = Double(string) { return value }
            fatalError("failed to convert \(string) to Double")
        }
    }
    
    var points: [CGPoint] {
        lines.map { string in
            let items = string.components(seperatedByCharactersIn: ", ")
            guard items.count == 2 else {
                fatalError("failed to convert \(string) to CGPoint, count = \(items.count)")
            }
            guard let x = Double(items[0]), let y = Double(items[1]) else {
                fatalError("failed to convert \(string) to CGPoint, items = \(items)")
            }
            return CGPoint(x: x, y: y)
        }
    }
}
