# Advent of Code 2020

These are my [Advent of Code 2020](https://adventofcode.com/2020) puzzle solutions. They are written in Swift and can be run as a command line tool on macOS with the included Xcode project.

## Running Puzzles

Edit `currentPuzzle` in `main.swift` to be the desired puzzle class and then run the `AdventOfCode` target.

#### Example output:

```
🚀 Running AOC1

Part 1 Solution: 1009899 | ⏱ 17ms

Part 2 Solution: 44211152 | ⏱ 162ms
```

## Testing Puzzles

Tests can be ran with the `AdventOfCodeTests` target.

#### Example test:

```swift
class AOCTests: XCTestCase {

    func testAOC1() {
        XCTAssertEqual(AOC1().solve1(input: "1721,979,366,299,675,1456"), 514579)
        XCTAssertEqual(AOC1().solve2(input: "1721,979,366,299,675,1456"), 241861950)
    }

}
```