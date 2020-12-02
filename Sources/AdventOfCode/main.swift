//  main.swift
//  AdventOfCode
//
//  Created by Dash on 11/29/20.
//

import ArgumentParser
import Foundation

let puzzleSet = PuzzleSet()

struct AdventOfCode: ParsableCommand {
    static let configuration = CommandConfiguration(abstract: "Runs puzzles for Advent of Code")
    
    @Argument(help: "The puzzle number to run.")
    var puzzleIndex: Int
    
    @Argument(help: "The cookie session to authenticate for downloading puzzle input.")
    var cookieSession: String?
    
    @Flag(help: "Force a download of puzzle input even if there's a local file cached.")
    var forceDownload = false
    
    func validate() throws {
        guard puzzleSet.supportedPuzzleIndexes.contains(puzzleIndex) else {
            throw ValidationError("Invalid '<puzzle-index>'. Supported indexes: \(puzzleSet.supportedPuzzleIndexes.map({"\($0)"}).joined(separator: ", "))")
        }
    }
    
    func run() {
        print("\n🗃 Preparing Input\n")

        let input = InputStore(cookieSession: cookieSession).input(for: puzzleIndex, forceDownload: forceDownload)
        
        guard let puzzle = puzzleSet.puzzle(at: puzzleIndex) else { fatalError("No puzzle with index \(puzzleIndex)") }

        print("\n🚀 Running \(String(describing: type(of: puzzle)))\n")

        let startDate1 = Date()
        print("Part 1 Solution: \(puzzle.solve1(input: input)) | ⏱ \(startDate1.milisecondsAgo)ms\n")

        let startDate2 = Date()
        print("Part 2 Solution: \(puzzle.solve2(input: input)) | ⏱ \(startDate2.milisecondsAgo)ms\n")
    }
}

AdventOfCode.main()
