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
}

fileprivate extension String {
    func scanHexDirections() -> [HexDirection] {
        var directions: [HexDirection] = []
        let scanner = Scanner(string: self)
        while !scanner.isAtEnd {
            for direction in HexDirection.allCases {
                if scanner.scanString(direction.rawValue) != nil {
                    directions.append(direction)
                    break
                }
            }
        }
        return directions
    }
}

fileprivate struct TileFloor {
    private var colorsByPoint: [Point: Bool] = [:]
    
    init(input: String) {
        input.lines.forEach { line in
            let point = line.scanHexDirections().reduce(Point(0, 0), { $0 + $1.offset })
            toggleColor(at: point)
        }
    }
    
    func isBlack(at point: Point) -> Bool {
        colorsByPoint[point] ?? false
    }
    
    mutating func toggleColor(at point: Point) {
        colorsByPoint[point] = !isBlack(at: point)
    }
    
    var blackCount: Int {
        colorsByPoint.count(passing: { $0.value })
    }
    
    mutating func toggleDay() {
        let allPoints = colorsByPoint.keys.reduce(into: Set<Point>(), { allPoints, point in
            allPoints.insert(point)
            point.hexNeighbors.forEach { allPoints.insert($0) }
        })
        
        let pointsToFlip = allPoints.filter { point in
            let neighborCount = HexDirection.allCases.count(passing: { isBlack(at: point + $0.offset) })
            return isBlack(at: point) ? (neighborCount == 0 || neighborCount > 2) : neighborCount == 2
        }
        
        pointsToFlip.forEach { toggleColor(at: $0) }
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
