//  AOC13.swift
//  AdventOfCode
//
//  Created by Dash on 12/12/20.
//

import Foundation

struct AOC13: Puzzle {
    func solve1(input: String) -> Int {
        let earliestPossibleDeparture = Int(input.lines[0])!
        let busIDs = input.lines[1].componentStrings.compactMap { Int($0) }
        let busDepartures = busIDs.map { (earliestPossibleDeparture / $0 + 1) * $0 }
        let earliestBusDeparture = busDepartures.min()!
        let busID = busIDs[busDepartures.firstIndex(of: earliestBusDeparture)!]
        return busID * (earliestBusDeparture - earliestPossibleDeparture)
    }
    
    func solve2(input: String) -> Int {
        let busIDStrings = input.lines[1].componentStrings
        let offsetsAndIDs = busIDStrings.enumerated().compactMap { Int($0.1) != nil ? (offset: $0.0, id: Int($0.1)!) : nil }
        return chineseRemainder(offsetsAndIDs.map { $0.id }, offsetsAndIDs.map { $0.id - $0.offset })
    }
}

// https://www.omnicalculator.com/math/chinese-remainder
func chineseRemainder(_ n: [Int], _ a: [Int]) -> Int {
    let N = n.reduce(1, *)
    let m = n.map { N / $0 }
    let v = zip(n, m).map { bezoutCoefficients($0, $1) }.map { $0.1 }
    let e = zip(v, m).map(*)
    let x = zip(a, e).map(*).reduce(0, +)
    return x % N
}

// https://en.wikipedia.org/wiki/Extended_Euclidean_algorithm#Pseudocode
func bezoutCoefficients(_ a: Int, _ b: Int) -> (Int, Int) {
    var (old_r, r) = (a, b)
    var (old_s, s) = (1, 0)
    var (old_t, t) = (0, 1)
    
    while r != 0 {
        let q = old_r / r
        (old_r, r) = (r, old_r - q * r)
        (old_s, s) = (s, old_s - q * s)
        (old_t, t) = (t, old_t - q * t)
    }
    
    return (old_s, old_t)
}
