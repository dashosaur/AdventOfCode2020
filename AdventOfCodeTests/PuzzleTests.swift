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
    
    func testAOC6() {
        let input = """
        abc

        a
        b
        c

        ab
        ac

        a
        a
        a
        a

        b
        """
        
        let puzzle = PuzzleSet().puzzle(at: 6)!
        XCTAssertEqual(puzzle.solve1(input: input), 11)
        XCTAssertEqual(puzzle.solve2(input: input), 6)
    }
    
    func testAOC7() {
        let input = """
        light red bags contain 1 bright white bag, 2 muted yellow bags.
        dark orange bags contain 3 bright white bags, 4 muted yellow bags.
        bright white bags contain 1 shiny gold bag.
        muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
        shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
        dark olive bags contain 3 faded blue bags, 4 dotted black bags.
        vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
        faded blue bags contain no other bags.
        dotted black bags contain no other bags.
        """
        
        let puzzle = PuzzleSet().puzzle(at: 7)!
        XCTAssertEqual(puzzle.solve1(input: input), 4)
        XCTAssertEqual(puzzle.solve2(input: input), 32)
    }
    
    func testAOC8() {
        let input = """
        nop +0
        acc +1
        jmp +4
        acc +3
        jmp -3
        acc -99
        acc +1
        jmp -4
        acc +6
        """
        
        let puzzle = PuzzleSet().puzzle(at: 8)!
        XCTAssertEqual(puzzle.solve1(input: input), 5)
        XCTAssertEqual(puzzle.solve2(input: input), 8)
    }
    
    func testAOC9() {
        let input = """
        35
        20
        15
        25
        47
        40
        62
        55
        65
        95
        102
        117
        150
        182
        127
        219
        299
        277
        309
        576
        """
        
        let puzzle = AOC9()
        XCTAssertEqual(puzzle.firstInvalidNumber(in: input.integers, bufferSize: 5), 127)
        let minMax = puzzle.minMaxOfSubrangeWithSum(127, in: input.integers)
        XCTAssertEqual(minMax.min, 15)
        XCTAssertEqual(minMax.max, 47)
    }
    
    func testAOC10() {
        let input = """
        16
        10
        15
        5
        1
        11
        7
        19
        6
        12
        4
        """
        
        let puzzle = PuzzleSet().puzzle(at: 10)!
        XCTAssertEqual(puzzle.solve1(input: input), 35)
        XCTAssertEqual(puzzle.solve2(input: input), 8)
    }
    
    func testAOC11() {
        let input = """
        L.LL.LL.LL
        LLLLLLL.LL
        L.L.L..L..
        LLLL.LL.LL
        L.LL.LL.LL
        L.LLLLL.LL
        ..L.L.....
        LLLLLLLLLL
        L.LLLLLL.L
        L.LLLLL.LL
        """
        
        let puzzle = PuzzleSet().puzzle(at: 11)!
        XCTAssertEqual(puzzle.solve1(input: input), 37)
        XCTAssertEqual(puzzle.solve2(input: input), 26)
    }
    
    func testAOC12() {
        let input = """
        F10
        N3
        F7
        R90
        F11
        """
        
        let puzzle = PuzzleSet().puzzle(at: 12)!
        XCTAssertEqual(puzzle.solve1(input: input), 25)
        XCTAssertEqual(puzzle.solve2(input: input), 286)
    }
    
    func testAOC14() {
        let puzzle = PuzzleSet().puzzle(at: 14)!
        
        let input1 = """
        mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
        mem[8] = 11
        mem[7] = 101
        mem[8] = 0
        """
        XCTAssertEqual(puzzle.solve1(input: input1), 165)
        
        let input2 = """
        mask = 000000000000000000000000000000X1001X
        mem[42] = 100
        mask = 00000000000000000000000000000000X0XX
        mem[26] = 1
        """
        XCTAssertEqual(puzzle.solve2(input: input2), 208)
    }
    
    func testAOC15() {
        let puzzle = PuzzleSet().puzzle(at: 15)!
        
        XCTAssertEqual(puzzle.solve1(input: "0,3,6"), 436)
        XCTAssertEqual(puzzle.solve1(input: "1,3,2"), 1)
        XCTAssertEqual(puzzle.solve1(input: "2,1,3"), 10)
        XCTAssertEqual(puzzle.solve1(input: "1,2,3"), 27)
        XCTAssertEqual(puzzle.solve1(input: "2,3,1"), 78)
        XCTAssertEqual(puzzle.solve1(input: "3,2,1"), 438)
        XCTAssertEqual(puzzle.solve1(input: "3,1,2"), 1836)
        
        // Disabled slow tests
//        XCTAssertEqual(puzzle.solve2(input: "0,3,6"), 175594)
//        XCTAssertEqual(puzzle.solve2(input: "1,3,2"), 2578)
//        XCTAssertEqual(puzzle.solve2(input: "2,1,3"), 3544142)
//        XCTAssertEqual(puzzle.solve2(input: "1,2,3"), 261214)
//        XCTAssertEqual(puzzle.solve2(input: "2,3,1"), 6895259)
//        XCTAssertEqual(puzzle.solve2(input: "3,2,1"), 18)
//        XCTAssertEqual(puzzle.solve2(input: "3,1,2"), 362)
    }
    
    func testAOC16() {
        let puzzle = AOC16()
        
        let input = """
        class: 1-3 or 5-7
        row: 6-11 or 33-44
        seat: 13-40 or 45-50

        your ticket:
        7,1,14

        nearby tickets:
        7,3,47
        40,4,50
        55,2,20
        38,6,12
        """
        XCTAssertEqual(puzzle.solve1(input: input), 71)
        XCTAssertEqual(puzzle.solve2(input: input, prefix:""), 98)
    }
    
    func testAOC17() {
        let puzzle = AOC17()
        
        let input = """
        .#.
        ..#
        ###
        """
        XCTAssertEqual(puzzle.solve1(input: input), 112)
        XCTAssertEqual(puzzle.solve2(input: input), 848)
    }

}
