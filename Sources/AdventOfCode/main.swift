//  main.swift
//  AdventOfCode
//
//  Created by Dash on 11/29/20.
//

import ArgumentParser
import Foundation

let puzzleSet = PuzzleSet()

struct AdventOfCode: ParsableCommand {
    static let configuration = CommandConfiguration(abstract: "Tools for Advent of Code",
                                                    subcommands: [RunPuzzle.self, ViewLeaderboard.self],
                                                    defaultSubcommand: RunPuzzle.self)
    
}

struct RunPuzzle: ParsableCommand {
    static let configuration = CommandConfiguration(abstract: "Runs puzzles for Advent of Code", subcommands: [])
    
    @Argument(help: "The puzzle number to run.")
    var puzzleIndex: Int
    
    @Option(help: "The cookie named \"session\" for adventofcode.com. Used to authenticate for downloading puzzle input. Optional if puzzle input is already stored in ./Input/<puzzle-index>.txt or provided with --input.")
    var cookie: String?
    
    @Option(help: "An input string to test run the puzzle with. The input file will not be downloaded or read if test input is provided.")
    var testInput: String?
    
    @Flag(help: "Force a download of puzzle input even if there's a local file cached.")
    var forceDownload = false
    
    @Flag(help: "Enable verbose print statements.")
    var verbose = false
    
    func validate() throws {
        guard puzzleSet.supportedPuzzleIndexes.contains(puzzleIndex) else {
            throw ValidationError("Invalid '<puzzle-index>'. Supported indexes: \(puzzleSet.supportedPuzzleIndexes.map({"\($0)"}).joined(separator: ", "))")
        }
    }
    
    func run() {
        enableVerbosePrints = verbose
        
        print("\n🗃 Preparing Input\n")
        
        if let cookie = cookie {
            HTTPCookieStorage.shared.configure(sessionCookie: cookie)
        }
        
        let input = testInput ?? InputStore().input(for: puzzleIndex, forceDownload: forceDownload)
        
        guard let puzzle = puzzleSet.puzzle(at: puzzleIndex) else { fatalError("No puzzle with index \(puzzleIndex)") }

        print("\n🚀 Running \(String(describing: type(of: puzzle)))\n")

        let startDate1 = Date()
        print("Part 1 Solution: \(puzzle.solve1(input: input)) | ⏱ \(startDate1.milisecondsAgo)ms\n")

        let startDate2 = Date()
        print("Part 2 Solution: \(puzzle.solve2(input: input)) | ⏱ \(startDate2.milisecondsAgo)ms\n")
    }
}

struct ViewLeaderboard: ParsableCommand {
    static let configuration = CommandConfiguration(abstract: "Prints out leaderboard statistics", subcommands: [])
    
    @Argument(help: "The leaderboard ID.")
    var leaderboardID: Int
    
    @Option(help: "The puzzle number to print statistics for.")
    var puzzleIndex: Int?
    
    @Option(help: "The cookie named \"session\" for adventofcode.com.")
    var cookie: String?
    
    func run() {
        if let cookie = cookie {
            HTTPCookieStorage.shared.configure(sessionCookie: cookie)
        }
        
        Leaderboard(ID: leaderboardID).printStatistics(puzzleIndex: puzzleIndex)
    }
}

AdventOfCode.main()
