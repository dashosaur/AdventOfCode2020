//  AOC16.swift
//  AdventOfCode
//
//  Created by Dash on 12/15/20.
//

import Foundation

struct AOC16: Puzzle {
    func solve1(input: String) -> Int {
        var validIndices = IndexSet()
        for line in input.lineGroups[0].lines {
            for rangeText in line.components(separatedBy: ": ")[1].components(separatedBy: " or ") {
                validIndices.insert(integersIn: rangeText.range)
            }
        }
        let nearbyTickets = input.lineGroups[2].lines[1...]
        let invalidValues = nearbyTickets.compactMap({ $0.integers.first(where: { !validIndices.contains($0) }) })
        return invalidValues.reduce(0, +)
    }
    
    func solve2(input: String) -> Int {
        solve2(input: input, prefix: "departure")
    }
    
    func solve2(input: String, prefix: String) -> Int {
        var validIndices = IndexSet()
        var validIndicesByField: [String: IndexSet] = [:]
        for line in input.lineGroups[0].lines {
            let components = line.components(separatedBy: ": ")
            let field = components[0]
            for rangeText in components[1].components(separatedBy: " or ") {
                validIndices.insert(integersIn: rangeText.range)
                var fieldIndices = validIndicesByField[field] ?? IndexSet()
                fieldIndices.insert(integersIn: rangeText.range)
                validIndicesByField[field] = fieldIndices
            }
        }
        
        let yourTicket = input.lineGroups[1].lines[1].integers
        let nearbyTickets = input.lineGroups[2].lines[1...]
            .map { $0.integers }
            .filter { $0.allSatisfy({ validIndices.contains($0) }) }
        
        // Create a set of valid fields for every index based on the nearby tickets
        let possibleFieldsByIndex: [Int: Set<String>] = yourTicket.indices.reduce(into: [:], { fieldsByIndex, index in
            let possibleFields = validIndicesByField.keys.filter { field in
                nearbyTickets.allSatisfy({ ticket in validIndicesByField[field]!.contains(ticket[index]) })
            }
            fieldsByIndex[index] = Set(possibleFields)
        })
        
        // Resolve the possible fields per index down to one assigned field for each index
        let fieldsByIndex = findFieldsByIndex(possibleFieldsByIndex: possibleFieldsByIndex)!
        
        // Return the product of all fields in your own ticket that start with a prefix
        return fieldsByIndex
            .filter { $0.value.starts(with: prefix) }
            .reduce(1) { $0 * yourTicket[$1.key] }
    }
    
    func findFieldsByIndex(possibleFieldsByIndex: [Int: Set<String>], fieldsByIndex: [Int: String] = [:]) -> [Int: String]? {
        // Base case: all fields are resolved
        if possibleFieldsByIndex.count == 0 {
            return fieldsByIndex
        }
        // Choose the unresolved index with the least possibilities
        let (index, possibleFields) = possibleFieldsByIndex.min(by: { $1.value.count > $0.value.count })!
        // Remove it from the unresolved dictionary and try every option to resolve it
        var newPossible = possibleFieldsByIndex
        newPossible.removeValue(forKey: index)
        for field in possibleFields {
            // Skip any fields that are already assigned to a resolved index
            if fieldsByIndex.values.contains(field) { continue }
            // Try assigning this field to this index and resolving recursively
            var newFieldsByIndex = fieldsByIndex
            newFieldsByIndex[index] = field
            if let resolvedFieldsByIndex = findFieldsByIndex(possibleFieldsByIndex: newPossible, fieldsByIndex: newFieldsByIndex) {
                return resolvedFieldsByIndex
            }
        }
        // Return nil if the remaining possibleFields are not resolvable
        return nil
    }
}
