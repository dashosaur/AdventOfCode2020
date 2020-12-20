//  AOC20.swift
//  AdventOfCode
//
//  Created by Dash on 12/19/20.
//

import Foundation

struct Tile: CustomStringConvertible {
    let id: Int
    let pixels: [[Bool]]
    private var transform: Transform = .none
    
    init(input: String) {
        let scanner = Scanner(string: input.lines[0])
        _ = scanner.scanString("Tile ")
        id = scanner.scanInt()!
        var pixelLines: [[Bool]] = []
        for line in input.lines[1...] {
            pixelLines.append(line.map({ $0 == "#" }))
        }
        pixels = pixelLines
    }
    
    init(id: Int, pixels: [[Bool]], transform: Transform = .none) {
        self.id = id
        self.pixels = pixels
        self.transform = transform
    }
    
    var activePixelsExcludingSeaMonsters: Int {
        // 3 x 20
        let offsets = [(0, 18), (1, 0), (1, 5), (1, 6), (1, 11), (1, 12), (1, 17), (1, 18), (1, 19), (2, 1), (2, 4), (2, 7), (2, 10), (2, 13), (2, 16)]
        let trPixels = transformedPixels
        guard trPixels.count >= 20 else { return 0 }
        
        var updatedPixels = trPixels
        var m = 0
        for row in 0...(trPixels.count - 3) {
            for column in 0...(trPixels.count - 20) {
                if offsets.allSatisfy({ trPixels[row+$0.0][column+$0.1] }) {
                    m += 1
                    for offset in offsets {
                        updatedPixels[row+offset.0][column+offset.1] = false
                    }
                }
            }
        }
        return updatedPixels.flatMap({ $0 }).count(passing: { $0 })
    }
    
    var right: [Bool] {
        switch transform {
        case .none: return C
        case .rotateOnce: return B
        case .rotateTwice: return A
        case .rotateThrice: return D
        case .flip: return C.reversed()
        case .flipAndRotateOnce: return D.reversed()
        case .flipAndRotateTwice: return A.reversed()
        case .flipAndRotateThrice: return B.reversed()
        }
    }
    
    var left: [Bool] {
        switch transform {
        case .none: return A
        case .rotateOnce: return D
        case .rotateTwice: return C
        case .rotateThrice: return B
        case .flip: return A.reversed()
        case .flipAndRotateOnce: return B.reversed()
        case .flipAndRotateTwice: return C.reversed()
        case .flipAndRotateThrice: return D.reversed()
        }
    }
    
    var top: [Bool] {
        switch transform {
        case .none: return B
        case .rotateOnce: return A
        case .rotateTwice: return D
        case .rotateThrice: return C
        case .flip: return D.reversed()
        case .flipAndRotateOnce: return A.reversed()
        case .flipAndRotateTwice: return B.reversed()
        case .flipAndRotateThrice: return C.reversed()
        }
    }
    
    var bottom: [Bool] {
        switch transform {
        case .none: return D
        case .rotateOnce: return C
        case .rotateTwice: return B
        case .rotateThrice: return A
        case .flip: return B.reversed()
        case .flipAndRotateOnce: return C.reversed()
        case .flipAndRotateTwice: return D.reversed()
        case .flipAndRotateThrice: return A.reversed()
        }
    }
    
    var transformedPixels: [[Bool]] {
        switch transform {
        case .none: return transformedPixels(flipped: false, rotations: 0)
        case .rotateOnce: return transformedPixels(flipped: false, rotations: 1)
        case .rotateTwice: return transformedPixels(flipped: false, rotations: 2)
        case .rotateThrice: return transformedPixels(flipped: false, rotations: 3)
        case .flip: return transformedPixels(flipped: true, rotations: 0)
        case .flipAndRotateOnce: return transformedPixels(flipped: true, rotations: 1)
        case .flipAndRotateTwice: return transformedPixels(flipped: true, rotations: 2)
        case .flipAndRotateThrice: return transformedPixels(flipped: true, rotations: 3)
        }
    }
    
    func transformedPixels(flipped: Bool, rotations: Int) -> [[Bool]] {
        var trPixels = pixels
        if flipped {
            trPixels = trPixels.reversed()
        }
        if rotations > 0 {
            for _ in 1...rotations {
                var rotated = trPixels
                for row in 0..<trPixels.count {
                    for column in 0..<trPixels.count {
                        rotated[column][trPixels.count - 1 - row] = trPixels[row][column]
                    }
                }
                trPixels = rotated
            }
        }
        return trPixels
    }
    
    var A: [Bool] { pixels.map({ $0.first! }).reversed() }
    var B: [Bool] { pixels[0] }
    var C: [Bool] { pixels.map({ $0.last! }) }
    var D: [Bool] { pixels.last!.reversed() }
    
    var description: String {
        "\(id), \(transform)\n" + transformedPixels.map({ $0.map({ b in b ? "#" : "."}).joined() }).joined(separator: "\n")
    }
    
    func applyingTransform(_ transform: Transform) -> Tile {
        Tile(id: id, pixels: pixels, transform: transform)
    }
    
    func matchesSide(side: [Bool]) -> Bool {
        if side == A { return true }
        if side == A.reversed() { return true }
        if side == B { return true }
        if side == B.reversed() { return true }
        if side == C { return true }
        if side == C.reversed() { return true }
        if side == D { return true }
        if side == D.reversed() { return true }
        return false
    }
}

enum Transform: CaseIterable {
    case none
    case rotateOnce
    case rotateTwice
    case rotateThrice
    case flip
    case flipAndRotateOnce
    case flipAndRotateTwice
    case flipAndRotateThrice
}

struct AOC20: Puzzle {
    
    func transformationsOfTile(_ tile: Tile, thatFitAt point: (row: Int, column: Int), in grid: [[Tile?]]) -> [Tile] {
        var validTiles = Transform.allCases.map({ tile.applyingTransform($0) })
        
        if point.column - 1 >= 0, let tileLeft = grid[point.row][point.column - 1] {
            validTiles.removeAll(where: { $0.left != tileLeft.right.reversed() })
        }
        
        if point.row - 1 >= 0, let tileAbove = grid[point.row - 1][point.column] {
            validTiles.removeAll(where: { $0.top != tileAbove.bottom.reversed() })
        }
        
        if point.column + 1 < grid.count, let tileRight = grid[point.row][point.column + 1] {
            validTiles.removeAll(where: { $0.right != tileRight.left.reversed() })
        }
        
        if point.row + 1 < grid.count, let tileBottom = grid[point.row + 1][point.column] {
            validTiles.removeAll(where: { $0.bottom != tileBottom.top.reversed() })
        }
        
        return validTiles
    }
    
    func solve(tiles: [Tile], grid: [[Tile?]]) -> [[Tile]]? {
        let resolvedTiles = grid.flatMap({ $0 }).compactMap({ $0 })
        
        // Check if the puzzle is complete
        if resolvedTiles.count == tiles.count {
            return grid.map({$0.compactMap({$0})})
        }
        
        // Find the first empty tile spot
        var emptyTile: (row: Int, column: Int)!
        for row in grid.indices {
            for col in grid[row].indices {
                if grid[row][col] == nil {
                    emptyTile = (row, col)
                    break
                }
            }
            if emptyTile != nil {
                break
            }
        }
        
        // Try all tiles / transformations in this spot and recursively solve the rest of the puzzle
        for tile in tiles.filter({ tile in !resolvedTiles.contains(where: { tile.id == $0.id }) }) {
            for trTile in transformationsOfTile(tile, thatFitAt: emptyTile, in: grid) {
                var newGrid = grid
                newGrid[emptyTile.row][emptyTile.column] = trTile
                if let solution = solve(tiles: tiles, grid: newGrid) {
                    return solution
                }
            }
        }
        
        return nil
    }
    
    func solve1(input: String) -> Int {
        let tiles = input.lineGroups.map { Tile(input: $0) }
        print(tiles.map({ $0.description }).joined(separator: "\n\n"))
        var cornerTileIDs: [Int] = []
        for tile in tiles {
            let sides = [tile.A, tile.B, tile.C, tile.D]
            let total = sides.reduce(0, { total, side in tiles.contains(where: { $0.matchesSide(side: side) && $0.id != tile.id }) ? total + 1 : total })
            if total == 2 {
                cornerTileIDs.append(tile.id)
            }
        }
        print("corners: \(cornerTileIDs)")
        return cornerTileIDs.reduce(1, *)
    }
    
    func solve2(input: String) -> Int {
        let tiles = input.lineGroups.map { Tile(input: $0) }
        let puzzleDimension = Int(Double(tiles.count).squareRoot())
        
        let emptyGrid: [[Tile?]] = Array(repeating: Array(repeating: nil, count: puzzleDimension), count: puzzleDimension)
        let solution = solve(tiles: tiles, grid: emptyGrid)!
        
        var allPixels: [[Bool]] = []
        for tileRow in solution {
            var subrows: [[Bool]] = Array(repeating: [], count: tiles.first!.pixels.count)
            for tile in tileRow {
                let pixels = tile.transformedPixels
                for (index, tilerow) in pixels.enumerated() {
                    subrows[index].append(contentsOf: tilerow.dropFirst().dropLast())
                }
            }
            allPixels.append(contentsOf: subrows.dropFirst().dropLast())
        }
        
        let fullPuzzle = Tile(id: 0, pixels: allPixels)
        print("solution (\(allPixels.count)x\(allPixels.first!.count)): \(fullPuzzle)")
        
        return Transform.allCases.map({ fullPuzzle.applyingTransform($0) }).map({ $0.activePixelsExcludingSeaMonsters }).min()!
    }
}
