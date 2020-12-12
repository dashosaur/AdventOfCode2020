//  AOC11.swift
//  AdventOfCode
//
//  Created by Dash on 12/10/20.
//

import Foundation

struct AOC11: Puzzle {
    class SeatMap {
        enum SeatState: String {
            case occupied = "#"
            case empty = "L"
            case floor = "."
            
            var occupiedSeat: Bool? {
                switch self {
                case .occupied:
                    return true
                case .empty:
                    return false
                case .floor:
                    return nil
                }
            }
        }
        
        private(set) var seats: [[SeatState]]
        
        init(input: String) {
            seats = input.lines.map({ $0.map({ SeatState(rawValue: "\($0)")! }) })
            printMap()
        }
        
        func printMap() {
            print(seats.map({$0.map({$0.rawValue}).joined()}).joined(separator: "\n"))
        }
        
        private func isSeatOccupied(at location: (row: Int, col: Int)) -> Bool? {
            guard (0..<seats.count).contains(location.row),
                  (0..<seats[0].count).contains(location.col) else {
                return false
            }
            return seats[location.row][location.col].occupiedSeat
        }
        
        private let offsets = [(-1,1), (-1,0), (-1,-1), (0,1), (0,-1), (1,0), (1,1), (1,-1)]
        private func countOccupied(around location: (row: Int, col: Int), lookPastFirst: Bool) -> Int {
            offsets.reduce(0, { count, offset in
                var nextLocation = location + offset
                var occupied = isSeatOccupied(at: nextLocation)
                if lookPastFirst {
                    while occupied == nil {
                        nextLocation = nextLocation + offset
                        occupied = isSeatOccupied(at: nextLocation)
                    }
                }
                return (occupied ?? false) ? count + 1 : count
            })
        }
        
        var countOccupied: Int {
            seats.reduce(0, { $0 + $1.count(passing: { $0 == .occupied }) })
        }
        
        private func runFrame(lookPastFirst: Bool, minCountToVacate: Int) -> Bool {
            var newSeats = seats
            for row in 0..<seats.count {
                for (col, seat) in seats[row].enumerated() {
                    let countAround = countOccupied(around: (row, col), lookPastFirst: lookPastFirst)
                    if seat == .empty, countAround == 0 {
                        newSeats[row][col] = .occupied
                    } else if seat == .occupied, countAround >= minCountToVacate {
                        newSeats[row][col] = .empty
                    }
                }
            }
            if newSeats != seats {
                seats = newSeats
                printMap()
                return true
            } else {
                return false
            }
        }
        
        func run(lookPastFirst: Bool, minCountToVacate: Int) {
            while runFrame(lookPastFirst: lookPastFirst, minCountToVacate: minCountToVacate) { }
        }
    }
    
    func solve1(input: String) -> Int {
        let map = SeatMap(input: input)
        map.run(lookPastFirst: false, minCountToVacate: 4)
        return map.countOccupied
    }
    
    func solve2(input: String) -> Int {
        let map = SeatMap(input: input)
        map.run(lookPastFirst: true, minCountToVacate: 5)
        return map.countOccupied
    }
}
