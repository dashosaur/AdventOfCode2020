//
//  PuzzleTests.swift
//  AdventOfCodeTests
//
//  Created by Dash on 11/29/20.
//

import XCTest

class PuzzleTests: XCTestCase {

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
    
    func testAOC3() {
        let input =
        """
        ..##.......
        #...#...#..
        .#....#..#.
        ..#.#...#.#
        .#...##..#.
        ..#.##.....
        .#.#.#....#
        .#........#
        #.##...#...
        #...##....#
        .#..#...#.#
        """
        
        let puzzle = PuzzleSet().puzzle(at: 3)!
        XCTAssertEqual(puzzle.solve1(input: input), 7)
        XCTAssertEqual(puzzle.solve2(input: input), 336)
    }
    
    func testAOC4() {
        let input =
        """
        ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
        byr:1937 iyr:2017 cid:147 hgt:183cm
        
        iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884
        hcl:#cfa07d byr:1929
        
        hcl:#ae17e1 iyr:2013
        eyr:2024
        ecl:brn pid:760753108 byr:1931
        hgt:179cm
        
        hcl:#cfa07d eyr:2025 pid:166559648
        iyr:2011 ecl:brn hgt:59in
        
        eyr:1972 cid:100
        hcl:#18171d ecl:amb hgt:170 pid:186cm iyr:2018 byr:1926

        iyr:2019
        hcl:#602927 eyr:1967 hgt:170cm
        ecl:grn pid:012533040 byr:1946

        hcl:dab227 iyr:2012
        ecl:brn hgt:182cm pid:021572410 eyr:2020 byr:1992 cid:277

        hgt:59cm ecl:zzz
        eyr:2038 hcl:74454a iyr:2023
        pid:3556412378 byr:2007
        """
        
        let puzzle = PuzzleSet().puzzle(at: 4)!
        XCTAssertEqual(puzzle.solve1(input: input), 6)
        XCTAssertEqual(puzzle.solve2(input: input), 2)
    }
    
    func testAOC5() {
        let puzzle = AOC5()
        XCTAssertEqual(puzzle.seatID(fromBoardingPass: "FBFBBFFRLR"), 357)
        XCTAssertEqual(puzzle.seatID(fromBoardingPass: "BFFFBBFRRR"), 567)
        XCTAssertEqual(puzzle.seatID(fromBoardingPass: "FFFBBBFRRR"), 119)
        XCTAssertEqual(puzzle.seatID(fromBoardingPass: "BBFFBBFRLL"), 820)
    }

}
