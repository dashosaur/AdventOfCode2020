//  AOC23.swift
//  AdventOfCode
//
//  Created by Dash on 12/22/20.
//

import Foundation

class Cup {
    let label: Int
    var next: Cup? = nil
    
    init(label: Int) {
        self.label = label
    }
}

class CupLoop {
    private var currentCup: Cup
    private var cupsByLabel: [Cup?]
    private let maxPossibleCupLabel: Int
    
    init(labels: [Int]) {
        // Create cups for each label and connect their next pointers in a loop
        var first: Cup? = nil
        var previous: Cup? = nil
        var cupsByLabel: [Cup?] = .init(repeating: nil, count: labels.count + 1)
        for label in labels {
            let cup = Cup(label: label)
            previous?.next = cup
            cupsByLabel[label] = cup
            
            first = first ?? cup
            previous = cup
        }
        previous!.next = first!
        
        currentCup = first!
        maxPossibleCupLabel = labels.max()!
        self.cupsByLabel = cupsByLabel
    }
    
    func playMove() {
        // Remove the 3 cups after the current one
        let current = cupsByLabel[currentCup.label]!
        let removedCups = [current.next!, current.next!.next!, current.next!.next!.next!]
        current.next = removedCups.last!.next
        removedCups.forEach { $0.next = nil }
        
        // Find the destination label
        let destinationLabel = (0...(currentCup.label - 1)).last(where: { hasCupForLabel($0) }) ?? maxCupLabel
        
        // Insert the 3 removed cups after the destination label
        let destinationCup = cupsByLabel[destinationLabel]!
        removedCups[0].next = removedCups[1]
        removedCups[1].next = removedCups[2]
        removedCups[2].next = destinationCup.next
        destinationCup.next = removedCups[0]
        
        // Move on to the next cup
        currentCup = currentCup.next!
    }
    
    private func hasCupForLabel(_ label: Int) -> Bool {
        cupsByLabel[label]?.next != nil
    }
    
    private var maxCupLabel: Int {
        (1...maxPossibleCupLabel).last(where: { hasCupForLabel($0) })!
    }
    
    var labelsAfterOne: [Int] {
        var labels = [Int]()
        var cur = cupsByLabel[1]!
        repeat {
            labels.append(cur.label)
            cur = cur.next!
        } while cur.label != 1
        return Array(labels[1...])
    }
}

struct AOC23: Puzzle {
    func solve1(input: String) -> Int {
        let labels = input.lines[0].map { Int(String($0))! }
        let cupLoop = CupLoop(labels: labels)
        
        for move in 1...100 {
            print("\n--Move \(move)--")
            cupLoop.playMove()
        }
        
        return Int(cupLoop.labelsAfterOne.map({ "\($0)" }).joined())!
    }
    
    func solve2(input: String) -> Int {
        var labels = input.lines[0].map { Int(String($0))! }
        ((labels.count + 1)...1000000).forEach { labels.append($0) }
        
        let cupLoop = CupLoop(labels: labels)
        
        for move in 1...10000000 {
            if move % 100000 == 0 {
                print("\n--Move \(move)--")
            }
            cupLoop.playMove()
        }
        
        return cupLoop.labelsAfterOne[..<2].reduce(1, *)
    }
}
