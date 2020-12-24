//  AOC21.swift
//  AdventOfCode
//
//  Created by Dash on 12/20/20.
//

import Foundation

struct AOC21: Puzzle {
    func parseInput(_ input: String) -> (possibleIngredientsByAllergen: [String: Set<String>], ingredientCounts: NSCountedSet) {
        var possibleIngredientsByAllergen: [String: Set<String>] = [:]
        let ingredientCounts = NSCountedSet()
        
        for line in input.lines {
            let split = line.removingCharacters(in: "(),").components(separatedBy: " contains ")
            let ingredients = split[0].componentStrings
            let allergens = split[safe: 1]?.componentStrings ?? []
            
            ingredientCounts.addObjects(from: ingredients)
            
            // For each allergen, find the intersection of all ingredient lists it appears in
            for allergen in allergens {
                if let possibleIngredients = possibleIngredientsByAllergen[allergen] {
                    possibleIngredientsByAllergen[allergen] = Set(ingredients).intersection(possibleIngredients)
                } else {
                    possibleIngredientsByAllergen[allergen] = Set(ingredients)
                }
            }
        }
        return (possibleIngredientsByAllergen, ingredientCounts)
    }
    
    func solve1(input: String) -> Int {
        let (possibleIngredientsByAllergen, ingredientCounts) = parseInput(input)
        
        // Find all ingredients that aren't possibly an allergen
        let nonAllergenIngredients = (ingredientCounts.allObjects as! [String]).filter({ ingredient in
            !possibleIngredientsByAllergen.values.contains(where: { $0.contains(ingredient) })
        })
        
        return nonAllergenIngredients.reduce(0) { $0 + ingredientCounts.count(for: $1) }
    }
    
    func solve2(input: String) -> Int {
        var (possibleIngredientsByAllergen, _) = parseInput(input)
        
        // Find the one ingredient each allergen is contained in
        var ingrediantByAllergen: [String: String] = [:]
        while possibleIngredientsByAllergen.count > 0 {
            if let ingredientsByAllergen = possibleIngredientsByAllergen.first(where: { $0.value.count == 1 }) {
                let ingredient = ingredientsByAllergen.value.first!
                
                // Move from the possible map to the resolved map
                possibleIngredientsByAllergen[ingredientsByAllergen.key] = nil
                ingrediantByAllergen[ingredientsByAllergen.key] = ingredient
                
                // Remove this ingredient from the possibilities for all other allergens
                for (allergen, possibleIngredients) in possibleIngredientsByAllergen {
                    possibleIngredientsByAllergen[allergen] = possibleIngredients.removing(ingredient)
                }
            }
        }
        
        // Print the ingredients sorted by allergen
        let ingredientsSortedByAllergen = ingrediantByAllergen.sorted(by: { $1.key > $0.key }).map({ $0.value })
        print("\(ingredientsSortedByAllergen.joined(separator: ","))\n")
        
        return 0
    }
}
