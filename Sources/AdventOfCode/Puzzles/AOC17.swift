//  AOC17.swift
//  AdventOfCode
//
//  Created by Dash on 12/15/20.
//

import Foundation

fileprivate class Map {
    class Point: Hashable, Equatable, CustomStringConvertible {
        let w: Int?
        let x: Int
        let y: Int
        let z: Int
        
        init(_ w: Int? = nil, _ x: Int, _ y: Int, _ z: Int) {
            self.w = w
            self.x = x
            self.y = y
            self.z = z
        }
        
        static func +(lhs: Point, rhs: Point) -> Point {
            let w: Int?
            if let lw = lhs.w, let rw = rhs.w {
                w = lw + rw
            } else {
                w = nil
            }
            return Point(w, lhs.x + rhs.x, lhs.y + rhs.y, lhs.z + rhs.z)
        }
        
        var description: String {
            if let w = w {
                return "(\(w), \(x), \(y), \(z))"
            } else {
                return "(\(x), \(y), \(z))"
            }
        }
        
        static func == (lhs: Map.Point, rhs: Map.Point) -> Bool {
            lhs.w == rhs.w && lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(w)
            hasher.combine(x)
            hasher.combine(y)
            hasher.combine(z)
        }
        
        lazy var neighbors: [Point] = {
            var points: [Point] = []
            let wOffsetRange = w != nil ? -1...1 : 0...0
            for wOffset in wOffsetRange {
                for xOffset in -1...1 {
                    for yOffset in -1...1 {
                        for zOffset in -1...1 {
                            let neighbor = self + Point(wOffset, xOffset, yOffset, zOffset)
                            if neighbor != self {
                                points.append(neighbor)
                            }
                        }
                    }
                }
            }
            return points
        }()
    }
    
    let dimensions: Int
    private(set) var activeCubes: Set<Point> = Set()
    
    init(input: String, dimensions: Int) {
        assert(dimensions == 3 || dimensions == 4)
        self.dimensions = dimensions
        
        for (y, line) in input.lines.enumerated() {
            for (x, char) in line.enumerated() where char == "#" {
                activeCubes.insert(Point(dimensions == 4 ? 0 : nil, x, y, 0))
            }
        }
    }
    
    var countActive: Int { activeCubes.count }
    
    private func runCycle() {
        var newActiveCubes = activeCubes
        
        // If a cube is currently active or neighboring an active cube it might need an update
        let cubesToCheck = activeCubes.reduce(into: activeCubes) { set, activeCube in
            activeCube.neighbors.forEach { set.insert($0) }
        }
        
        // Update active cubes to inactive if they don't have 2-3 active neighbors
        // Update inactive cubes to active if they have 3 active neighbors
        for cube in cubesToCheck {
            let isActive = activeCubes.contains(cube)
            let activeNeighborCount = cube.neighbors.count(passing: { activeCubes.contains($0) })
            if isActive && !(2...3).contains(activeNeighborCount) {
                newActiveCubes.remove(cube)
            }
            if !isActive && activeNeighborCount == 3 {
                newActiveCubes.insert(cube)
            }
        }
        
        activeCubes = newActiveCubes
    }
    
    func run(count: Int) {
        print("Before any cycles:")
        printMap()
        for cycle in 1...6 {
            runCycle()
            print("After \(cycle) cycles:")
            printMap()
        }
    }
    
    func printMap() {
        let x = Array(activeCubes.reduce(into: Set<Int>(), { $0.insert($1.x) })).sorted()
        let y = Array(activeCubes.reduce(into: Set<Int>(), { $0.insert($1.y) })).sorted()
        for z in Array(activeCubes.reduce(into: Set<Int>(), { $0.insert($1.z) })).sorted() {
            print("\nz=\(z)\(dimensions == 4 ? ", w=0" : "")")
            let cubes = activeCubes.filter({ $0.z == z })
            for y in y.first!...y.last! {
                print((x.first!...x.last!).map({ cubes.contains(Point(dimensions == 4 ? 0 : nil, $0, y, z)) ? "#" : "." }).joined(separator: ""))
            }
        }
        print("\n")
    }
}

struct AOC17: Puzzle {
    func solve1(input: String) -> Int {
        let map = Map(input: input, dimensions: 3)
        map.run(count: 6)
        return map.countActive
    }
    
    func solve2(input: String) -> Int {
        let map = Map(input: input, dimensions: 4)
        map.run(count: 6)
        return map.countActive
    }
}
