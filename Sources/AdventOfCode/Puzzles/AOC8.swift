//  AOC8.swift
//  AdventOfCode
//
//  Created by Dash on 12/7/20.
//

import Foundation

struct AOC8: Puzzle {
    func solve1(input: String) -> Int {
        let program = Program(instructions: input.instructions)
        _ = program.run()
        return program.accumulator
    }
    
    func solve2(input: String) -> Int {
        let instructions = input.instructions
        for (index, instruction) in instructions.enumerated() {
            var updatedInstructions = instructions
            switch instruction.operation {
            case .nop:
                updatedInstructions[index] = Program.Instruction(operation: .jmp, argument: instruction.argument)
            case .jmp:
                updatedInstructions[index] = Program.Instruction(operation: .nop, argument: instruction.argument)
            case .acc:
                continue
            }
            let program = Program(instructions: updatedInstructions)
            if program.run() {
                return program.accumulator
            }
        }
        fatalError("No programs completed successfully")
    }
}
