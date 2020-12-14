//  AOC14.swift
//  AdventOfCode
//
//  Created by Dash on 12/13/20.
//

import Foundation

fileprivate enum Instruction {
    case updateMask(mask: String)
    case assignValue(value: Int, address: Int)
    
    init(text: String) {
        let scanner = Scanner(string: text)
        if let word = scanner.scanCharacters(from: .alphanumerics), word == "mask" {
            _ = scanner.scanCharacter()
            self = .updateMask(mask: scanner.scanCharacters(from: .alphanumerics)!)
        } else {
            _ = scanner.scanCharacter()
            let address = scanner.scanInt()!
            _ = scanner.scanString("] = ")
            let value = scanner.scanInt()!
            self = .assignValue(value: value, address: address)
        }
    }
}

struct AOC14: Puzzle {
    func solve1(input: String) -> Int {
        var memory: [Int : Int] = [:]
        var mask: String? = nil
        for line in input.lines {
            let instruction = Instruction(text: line)
            switch instruction {
            case .updateMask(let m):
                mask = m
            case .assignValue(let value, let address):
                guard let mask = mask else { fatalError("Assigning a value before a mask") }
                let paddedValue = String(value, radix: 2, length: mask.count)
                let maskedValue = zip(paddedValue, mask).map { $1 == "X" ? $0 : $1 }
                memory[address] = Int(String(maskedValue), radix: 2)
            }
        }
        return memory.values.reduce(0, +)
    }
    
    func solve2(input: String) -> Int {
        func allPossibleAddresses(from address: String) -> Array<String> {
            var addressesToProcess: [String] = [address]
            var completedAddresses: [String] = []
            while let address = addressesToProcess.popLast() {
                let newAddresses = [address.replacingFirst(of: "X", with: "0"), address.replacingFirst(of: "X", with: "1")]
                if address.count(of: "X") > 1 {
                    addressesToProcess.append(contentsOf: newAddresses)
                } else {
                    completedAddresses.append(contentsOf: newAddresses)
                }
            }
            return completedAddresses
        }
        
        var memory: [Int : Int] = [:]
        var mask: String? = nil
        for line in input.lines {
            let instruction = Instruction(text: line)
            switch instruction {
            case .updateMask(let m):
                mask = m
            case .assignValue(let value, let address):
                guard let mask = mask else { fatalError("Assigning a value before a mask") }
                let paddedAddress = String(address, radix: 2, length: mask.count)
                let maskedAddress = zip(paddedAddress, mask).map { $1 == "0" ? $0 : $1 }
                for address in allPossibleAddresses(from: String(maskedAddress)) {
                    memory[Int(address, radix: 2)!] = value
                }
            }
        }
        return memory.values.reduce(0, +)
    }
}
