//  AOC22.swift
//  AdventOfCode
//
//  Created by Dash on 12/21/20.
//

import Foundation

enum Player: CustomStringConvertible {
    case player1
    case player2
    
    var description: String {
        switch self {
        case .player1: return "Player 1"
        case .player2: return "Player 2"
        }
    }
    
    func deck(fromDeck1 deck1: [Int], deck2: [Int]) -> [Int] {
        switch self {
        case .player1: return deck1
        case .player2: return deck2
        }
    }
    
    func deck(fromDecks decks: [Player : [Int]]) -> [Int] {
        decks[self]!
    }
}

struct AOC22: Puzzle {
    
    func parseDecks(from input: String) -> [Player : [Int]] {
        let deck1 = input.lineGroups[0].lines[1...].map({ Int($0)! })
        let deck2 = input.lineGroups[1].lines[1...].map({ Int($0)! })
        return [.player1: deck1, .player2: deck2]
    }
    
    func calculateScore(of deck: [Int]) -> Int {
        deck.reversed().enumerated().reduce(0, { $0 + ($1.offset + 1) * $1.element })
    }
    
    func playCombat(decks: [Player : [Int]]) -> (winner: Player, decks: [Player : [Int]]) {
        var deck1 = decks[.player1]!
        var deck2 = decks[.player2]!
        
        verbosePrint("Player 1's deck: \(deck1)")
        verbosePrint("Player 2's deck: \(deck2)")
        
        while deck1.count > 0 && deck2.count > 0 {
            let top1 = deck1.removeFirst()
            let top2 = deck2.removeFirst()
            if top1 > top2 {
                deck1.append(contentsOf: [top1, top2])
            } else {
                deck2.append(contentsOf: [top2, top1])
            }
        }
        
        verbosePrint("\n== Post-game results ==")
        verbosePrint("Player 1's deck: \(deck1)")
        verbosePrint("Player 2's deck: \(deck2)\n")
        
        return (deck1.count > 0 ? .player1 : .player2, [.player1: deck1, .player2: deck2])
    }
    
    func playRecursiveCombat(decks: [Player : [Int]], globalGameNumber: inout Int) -> (winner: Player, decks: [Player : [Int]]) {
        let gameNumber = globalGameNumber
        
        verbosePrint("\n== Game \(gameNumber) ==")
        var deck1 = decks[.player1]!
        var deck2 = decks[.player2]!
        var pastDecks = Set<[[Int]]>()
        
        var winner: Player = deck1.count > deck2.count ? .player1 : .player2
        
        var round = 1
        while deck1.count > 0 && deck2.count > 0 {
            verbosePrint("\n-- Round \(round) (Game \(gameNumber)) --")
            verbosePrint("Player 1's deck: \(deck1)")
            verbosePrint("Player 2's deck: \(deck2)")
            
            // Break the loop if we've seen these decks before
            if pastDecks.contains([deck1, deck2]) {
                winner = .player1
                verbosePrint("\(Player.player1) wins round \(round) of game \(gameNumber)! (Due to infinite loop)")
                break
            }
            pastDecks.insert([deck1, deck2])
            
            // Each player picks their first card
            let top1 = deck1.removeFirst()
            let top2 = deck2.removeFirst()
            verbosePrint("Player 1 plays: \(top1)")
            verbosePrint("Player 2 plays: \(top2)")
            
            // Play recursively if there's enough cards left, otherwise the biggest number wins
            if top1 <= deck1.count, top2 <= deck2.count {
                verbosePrint("Playing a sub-game to determine the winner...")
                globalGameNumber = globalGameNumber + 1
                winner = playRecursiveCombat(decks: [.player1: Array(deck1[..<top1]), .player2: Array(deck2[..<top2])], globalGameNumber: &globalGameNumber).winner
                verbosePrint("\n...anyway, back to game 1.")
            } else {
                winner = top1 > top2 ? .player1 : .player2
            }
            verbosePrint("\(winner) wins round \(round) of game \(gameNumber)!")
            
            // Give the two cards to the winner's deck (winning card first)
            switch winner {
            case .player1:
                deck1.append(contentsOf: [top1, top2])
            case .player2:
                deck2.append(contentsOf: [top2, top1])
            }
            
            round += 1
        }
        verbosePrint("The winner of game \(gameNumber) is \(winner)!")
        return (winner, [.player1: deck1, .player2: deck2])
    }
    
    func solve1(input: String) -> Int {
        let decks = parseDecks(from: input)
        let result = playCombat(decks: decks)
        return calculateScore(of: result.winner.deck(fromDecks: result.decks))
    }
    
    func solve2(input: String) -> Int {
        let decks = parseDecks(from: input)
        
        var globalGameNumber = 1
        let result = playRecursiveCombat(decks: decks, globalGameNumber: &globalGameNumber)
        
        verbosePrint("\n== Post-game results ==")
        verbosePrint("Player 1's deck: \(Player.player1.deck(fromDecks: result.decks))")
        verbosePrint("Player 2's deck: \(Player.player2.deck(fromDecks: result.decks))\n")
        
        return calculateScore(of: result.winner.deck(fromDecks: result.decks))
    }
}
