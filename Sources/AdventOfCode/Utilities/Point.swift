//  Point.swift
//  AdventOfCode
//
//  Created by Dash on 12/11/20.
//

import Foundation

infix operator %%: MultiplicationPrecedence
func %%<T: BinaryInteger>(lhs: T, rhs: T) -> T {
    return (lhs % rhs + rhs) % rhs
}

struct Point: Hashable {
    let x: Int
    let y: Int
    
    init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }
    
    static let origin = Point(0, 0)
    
    static func +(lhs: Point, rhs: Point) -> Point {
        Point(lhs.x + rhs.x, lhs.y + rhs.y)
    }
    
    static func *(value: Int, point: Point) -> Point {
        Point(point.x * value, point.y * value)
    }
    
    func rotate(turns: Int) -> Point {
        (0..<(turns %% 4)).reduce(self) { p, _ in Point(p.y, -p.x) }
    }
    
    var manhattanDistance: Int {
        abs(x) + abs(y)
    }
}
