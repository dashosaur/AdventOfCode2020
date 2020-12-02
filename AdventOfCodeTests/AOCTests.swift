//
//  AOCTests.swift
//  AdventOfCodeTests
//
//  Created by Dash on 11/29/20.
//

import XCTest

class AOCTests: XCTestCase {

    func testExample() {
        XCTAssertEqual(Example().solve1(input: "12,16"), 5)
        XCTAssertEqual(Example().solve2(input: "100756"), 50346)
    }
    
    func testAOC1() {
        XCTAssertEqual(AOC1().solve1(input: "1721,979,366,299,675,1456"), 514579)
        XCTAssertEqual(AOC1().solve2(input: "1721,979,366,299,675,1456"), 241861950)
    }
    
    func testAOC2() {
        XCTAssertEqual(AOC2().solve1(input: "1-3 a: abcde"), 1)
        XCTAssertEqual(AOC2().solve1(input: "1-3 b: cdefg"), 0)
        XCTAssertEqual(AOC2().solve1(input: "2-9 c: ccccccccc"), 1)
        XCTAssertEqual(AOC2().solve1(input: "1-3 a: abcde\n1-3 b: cdefg\n2-9 c: ccccccccc"), 2)
        
        XCTAssertEqual(AOC2().solve2(input: "1-3 a: abcde"), 1)
        XCTAssertEqual(AOC2().solve2(input: "1-3 b: cdefg"), 0)
        XCTAssertEqual(AOC2().solve2(input: "2-9 c: ccccccccc"), 0)
        XCTAssertEqual(AOC2().solve2(input: "1-3 a: abcde\n1-3 b: cdefg\n2-9 c: ccccccccc"), 1)
    }

}
