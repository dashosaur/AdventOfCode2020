//  AOC22.swift
//  AdventOfCode
//
//  Created by Dash on 12/21/20.
//

import Foundation

enum Player: CustomStringConvertible {
    case one
    case two
    
    var description: String {
        switch self {
        case .one: return "Player 1"
        case .two: return "Player 2"
        }
    }
    
    func deck(fromDeck1 deck1: [Int], deck2: [Int]) -> [Int] {
        switch self {
        case .one: return deck1
        case .two: return deck2
        }
    }
    
    func deck(fromDecks decks: [Player : [Int]]) -> [Int] {
        decks[self]!
    }
}

struct AOC22: Puzzle {
    
    func parseDecks(input: String) -> [Player : [Int]] {
        let deck1 = input.lineGroups[0].lines[1...].map({ Int($0)! })
        let deck2 = input.lineGroups[1].lines[1...].map({ Int($0)! })
        return [.one: deck1, .two: deck2]
    }
    
    func calculateScore(of deck: [Int]) -> Int {
        deck.reversed().enumerated().reduce(0, { $0 + ($1.offset + 1) * $1.element })
    }
    
    func solve1(input: String) -> Int {
        let decks = parseDecks(input: input)
        var deck1 = decks[.one]!
        var deck2 = decks[.two]!
        
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
        
        let winDeck = deck2.count > 0 ? deck2 : deck1
        return calculateScore(of: winDeck)
    }
    
    func playRecursive(decks: [Player : [Int]], game: inout Int) -> (winner: Player, decks: [Player : [Int]]) {
        game = game + 1
        
        verbosePrint("\n== Game \(game) ==")
        var deck1 = decks[.one]!
        var deck2 = decks[.two]!
        var pastDecks = Set<[[Int]]>()
        
        var winner: Player = deck1.count > deck2.count ? .one : .two
        
        var round = 1
        while deck1.count > 0 && deck2.count > 0 {
            verbosePrint("\n-- Round \(round) (Game \(game)) --")
            verbosePrint("Player 1's deck: \(deck1)")
            verbosePrint("Player 2's deck: \(deck2)")
            
            // Break the loop if we've seen these decks before
            if pastDecks.contains([deck1, deck2]) {
                winner = .one
                verbosePrint("\(Player.one) wins round \(round) of game \(game)! (Due to infinite loop)")
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
                winner = playRecursive(decks: [.one: Array(deck1[..<top1]), .two: Array(deck2[..<top2])], game: &game).winner
                verbosePrint("\n...anyway, back to game 1.")
            } else {
                winner = top1 > top2 ? .one : .two
            }
            verbosePrint("\(winner) wins round \(round) of game \(game)!")
            
            // Give the two cards to the winner's deck (winning card first)
            switch winner {
            case .one:
                deck1.append(contentsOf: [top1, top2])
            case .two:
                deck2.append(contentsOf: [top2, top1])
            }
            
            round += 1
        }
        verbosePrint("The winner of game \(game) is \(winner)!")
        return (winner, [.one: deck1, .two: deck2])
    }
    
    func solve2(input: String) -> Int {
        var game = 0
        
        let decks = parseDecks(input: input)
        let result = playRecursive(decks: decks, game: &game)
        
        verbosePrint("\n\n== Post-game results ==")
        verbosePrint("Player 1's deck: \(Player.one.deck(fromDecks: result.decks))")
        verbosePrint("Player 2's deck: \(Player.two.deck(fromDecks: result.decks))")
        
        return calculateScore(of: result.winner.deck(fromDecks: result.decks))
    }
}
