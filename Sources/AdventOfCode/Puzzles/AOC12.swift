//  AOC12.swift
//  AdventOfCode
//
//  Created by Dash on 12/11/20.
//

import Foundation

fileprivate extension Point {
    func move(direction: Direction, amount: Int, vector: Point? = nil) -> Point {
        switch direction {
        case .forward:
            return self + (amount * vector!)
        case .right:
            return rotate(turns: amount)
        case .left:
            return rotate(turns: -amount)
        case .east:
            return self + Point(amount, 0)
        case .west:
            return self + Point(-amount, 0)
        case .north:
            return self + Point(0, amount)
        case .south:
            return self + Point(0, -amount)
        }
    }
}

fileprivate enum Direction: Character {
    case forward = "F"
    case right = "R"
    case left = "L"
    case east = "E"
    case west = "W"
    case north = "N"
    case south = "S"
    
    var isRotation: Bool {
        switch self {
        case .right, .left:
            return true
        default:
            return false
        }
    }
}

class AOC12: Puzzle {
    fileprivate func scanMove(line: String) -> (direction: Direction, amount: Int) {
        let scanner = Scanner(string: line)
        let direction = Direction(rawValue: scanner.scanCharacter()!)!
        let amount = scanner.scanInt()!
        if direction.isRotation {
            return (direction, amount / 90)
        } else {
            return (direction, amount)
        }
    }
    
    func solve1(input: String) -> Int {
        var ship = Point(0, 0)
        var vector = Point(1, 0)
        for line in input.lines {
            let move = scanMove(line: line)
            if move.direction.isRotation {
                vector = vector.move(direction: move.direction, amount: move.amount)
            } else {
                ship = ship.move(direction: move.direction, amount: move.amount, vector: vector)
            }
        }
        return ship.manhattanDistance
    }
    
    func solve2(input: String) -> Int {
        var ship = Point(0, 0)
        var waypoint = Point(10, 1)
        for line in input.lines {
            let move = scanMove(line: line)
            if move.direction == .forward {
                ship = ship.move(direction: move.direction, amount: move.amount, vector: waypoint)
            } else {
                waypoint = waypoint.move(direction: move.direction, amount: move.amount)
            }
        }
        return ship.manhattanDistance
    }
}
