//  AOC4.swift
//  AdventOfCode
//
//  Created by Dash on 12/3/20.
//

import Foundation

fileprivate struct Passport {
    enum HeightUnit: String {
        case inches = "in"
        case centimeters = "cm"
    }
    
    enum EyeColor: String {
        case amber = "amb"
        case blue = "blu"
        case brown = "brn"
        case gray = "gry"
        case green = "grn"
        case hazel = "hzl"
        case other = "oth"
    }
    
    enum Field: String, CaseIterable {
        case birthYear = "byr"
        case issueYear = "iyr"
        case expirationYear = "eyr"
        case height = "hgt"
        case hairColor = "hcl"
        case eyeColor = "ecl"
        case passportID = "pid"
        case countryID = "cid"
        
        var isRequired: Bool {
            switch self {
            case .birthYear, .issueYear, .expirationYear, .height, .hairColor, .eyeColor, .passportID:
                return true
            case .countryID:
                return false
            }
        }
        
        func acceptsValue(_ value: String?) -> Bool {
            guard let value = value else {
                return !isRequired
            }
            
            switch self {
            case .birthYear:
                return Int(value).map { (1920...2002).contains($0) } ?? false
            case .issueYear:
                return Int(value).map { (2010...2020).contains($0) } ?? false
            case .expirationYear:
                return Int(value).map { (2020...2030).contains($0) } ?? false
            case .height:
                let scanner = Scanner(string: value)
                if let value = scanner.scanInt(),
                   let unitString = scanner.scanCharacters(from: .alphanumerics),
                   let unit = HeightUnit(rawValue: unitString) {
                    switch unit {
                    case .inches:
                        return (59...76).contains(value)
                    case .centimeters:
                        return (150...193).contains(value)
                    }
                } else {
                    return false
                }
            case .hairColor:
                let scanner = Scanner(string: value)
                if let character = scanner.scanCharacter(), character == "#" {
                    if let hexDigits = scanner.scanCharacters(from: CharacterSet(charactersIn: "0123456789abcdef")), hexDigits.count == 6 {
                        return true
                    }
                }
                return false
            case .eyeColor:
                return EyeColor(rawValue: value) != nil
            case .passportID:
                let scanner = Scanner(string: value)
                if let id = scanner.scanCharacters(from: .decimalDigits), id.count == 9 {
                    return true
                }
                return false
            case .countryID:
                return true
            }
        }
    }
    
    let attributes: [Field : String]
    
    init(string: String) {
        var attributes: [Field : String] = [:]
        for attributeString in string.componentStrings {
            let split = attributeString.components(seperatedByCharactersIn: ":")
            attributes[Field(rawValue: split[0])!] = split[1]
        }
        self.attributes = attributes
    }
    
    var isValid: Bool {
        Field.allCases.allPassCheck { $0.acceptsValue(attributes[$0]) }
    }
    
    var hasRequiredComponents: Bool {
        Field.allCases.allPassCheck { attributes[$0] != nil || !$0.isRequired }
    }
}

struct AOC4: Puzzle {
    func solve1(input: String) -> Int {
        input.components(separatedBy: "\n\n").count(passing: { Passport(string: $0).hasRequiredComponents })
    }
    
    func solve2(input: String) -> Int {
        input.components(separatedBy: "\n\n").count(passing: { Passport(string: $0).isValid })
    }
}
