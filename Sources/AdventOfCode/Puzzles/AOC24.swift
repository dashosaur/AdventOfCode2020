//  AOC24.swift
//  AdventOfCode
//
//  Created by Dash on 12/23/20.
//

import Foundation

fileprivate enum HexDirection: String, CaseIterable {
    case e
    case se
    case sw
    case w
    case nw
    case ne
    
    var offset: Point {
        switch self {
        case .e:    return Point(2, 0)
        case .ne:   return Point(1, 1)
        case .nw:   return Point(-1, 1)
        case .w:    return Point(-2, 0)
        case .sw:   return Point(-1, -1)
        case .se:   return Point(1, -1)
        }
    }
}

fileprivate extension Point {
    var hexNeighbors: [Point] {
        HexDirection.allCases.map { self + $0.offset }
    }
    
    func countHexNeighbors(where predicate: (Point) -> Bool) -> Int {
        HexDirection.allCases.count { predicate(self + $0.offset) }
    }
    
    func movingInDirection(_ direction: HexDirection) -> Point {
        self + direction.offset
    }
}

fileprivate extension String {
    var hexDirections: [HexDirection] {
        var directions: [HexDirection] = []
        let scanner = Scanner(string: self)
        while let direction = scanner.scanHexDirection() {
            directions.append(direction)
        }
        return directions
    }
}

fileprivate extension Scanner {
    func scanHexDirection() -> HexDirection? {
        HexDirection.allCases.first { scanString($0.rawValue) != nil }
    }
}

fileprivate struct TileFloor {
    private var blackTiles = Set<Point>()
    
    init(input: String) {
        input.lines.forEach { line in
            let point = line.hexDirections.reduce(Point.origin) { $0.movingInDirection($1) }
            toggleColor(at: point)
        }
    }
    
    func isBlack(at point: Point) -> Bool {
        blackTiles.contains(point)
    }
    
    mutating func toggleColor(at point: Point) {
        blackTiles.formSymmetricDifference([point])
    }
    
    mutating func toggleColor(at points: Set<Point>) {
        blackTiles.formSymmetricDifference(points)
    }
    
    var blackCount: Int {
        blackTiles.count
    }
    
    mutating func toggleDay() {
        let allPoints = blackTiles.reduce(into: Set<Point>()) { allPoints, point in
            allPoints.insert(point)
            point.hexNeighbors.forEach { allPoints.insert($0) }
        }
        
        let pointsToFlip = allPoints.filter { point in
            let neighborCount = point.countHexNeighbors(where: { isBlack(at: $0) })
            return isBlack(at: point) ? (neighborCount == 0 || neighborCount > 2) : neighborCount == 2
        }
        
        toggleColor(at: pointsToFlip)
    }
}

struct AOC24: Puzzle {
    func solve1(input: String) -> Int {
        TileFloor(input: input).blackCount
    }
    
    func solve2(input: String) -> Int {
        var tileFloor = TileFloor(input: input)
        for _ in 1...100 {
            tileFloor.toggleDay()
        }
        return tileFloor.blackCount
    }
}
