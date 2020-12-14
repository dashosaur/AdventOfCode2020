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
                let paddedValue = String(value, radix: 2).leftPadding(toLength: 36, withPad: "0")
                let maskedValue = zip(paddedValue, mask).map({ $1 == "X" ? $0 : $1 })
                memory[address] = Int(String(maskedValue), radix: 2)
            }
        }
        return memory.values.reduce(0, +)
    }
    
    func allPossibleAddresses(from address: String) -> Set<String> {
        var addressesToProcess: Set<String> = Set()
        addressesToProcess.insert(address)
        var completedAddresses: Set<String> = Set()
        while let address = addressesToProcess.popFirst() {
            let address0 = address.replacingFirst(of: "X", with: "0")
            let address1 = address.replacingFirst(of: "X", with: "1")
            if address.count(of: "X") > 1 {
                addressesToProcess.insert(address0)
                addressesToProcess.insert(address1)
            } else {
                completedAddresses.insert(address0)
                completedAddresses.insert(address1)
            }
        }
        return completedAddresses
    }
    
    func solve2(input: String) -> Int {
        var memory: [Int : Int] = [:]
        var mask: String? = nil
        for line in input.lines {
            let instruction = Instruction(text: line)
            switch instruction {
            case .updateMask(let m):
                mask = m
            case .assignValue(let value, let address):
                guard let mask = mask else { fatalError("Assigning a value before a mask") }
                let paddedAddress = String(address, radix: 2).leftPadding(toLength: 36, withPad: "0")
                let maskedAddress = zip(paddedAddress, mask).map({ $1 == "0" ? $0 : $1 })
                for address in allPossibleAddresses(from: String(maskedAddress)) {
                    memory[Int(address, radix: 2)!] = value
                }
            }
        }
        return memory.values.reduce(0, +)
    }
}

extension String {
    func leftPadding(toLength length: Int, withPad character: Character) -> String {
        String(repeatElement(character, count: max(length - count, 0))) + self
    }
    
    func replacingFirst(of target: String, with replacement: String) -> String {
        if let range = self.range(of: target) {
            return self.replacingCharacters(in: range, with: replacement)
        } else {
            return self
        }
    }
}
