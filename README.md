# Advent of Code 2020

These are (soon to be) my [Advent of Code 2020](https://adventofcode.com/2020) puzzle solutions. They are written in Swift and can be run with the included Xcode project.

## Running Puzzles

Edit `currentPuzzle` in `main.swift` to be the desired puzzle class and then run the `AdventOfCode` target.

#### Example output:

```
🚀 Started AOC1

Solution: 100

⏱ Finished in 2ms
```

## Testing Puzzles

Tests can be ran with the `AdventOfCodeTests` target.

#### Example test:

```swift
class AOCTests: XCTestCase {

    func testAll() {
        XCTAssertEqual(AOC1().solve(), 100)
    }

}
```