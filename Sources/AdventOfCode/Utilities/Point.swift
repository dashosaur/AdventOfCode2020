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

struct Point {
    let x: Int
    let y: Int
    
    static func +(lhs: Point, rhs: Point) -> Point {
        Point(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
    
    static func *(value: Int, point: Point) -> Point {
        Point(x: point.x * value, y: point.y * value)
    }
    
    func rotate(turns: Int) -> Point {
        (0..<(turns %% 4)).reduce(self, { p, _ in Point(x: p.y, y: -p.x) })
    }
    
    var manhattanDistance: Int {
        abs(x) + abs(y)
    }
}
