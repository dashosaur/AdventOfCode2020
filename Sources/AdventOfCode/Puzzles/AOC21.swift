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
        
        let nonAllergenIngredients = (ingredientCounts.allObjects as! [String]).filter({ ingredient in
            !possibleIngredientsByAllergen.values.contains(where: { $0.contains(ingredient) })
        })
        
        return nonAllergenIngredients.reduce(0, { $0 + ingredientCounts.count(for: $1) })
    }
    
    func solve2(input: String) -> Int {
        var (possibleIngredientsByAllergen, _) = parseInput(input)
        
        var ingrediantsByAllergen: [String: String] = [:]
        while possibleIngredientsByAllergen.count > 0 {
            if let ingredientByAllergen = possibleIngredientsByAllergen.first(where: { $0.value.count == 1 }) {
                let ingredient = ingredientByAllergen.value.first!
                ingrediantsByAllergen[ingredientByAllergen.key] = ingredient
                for (allergen, possibleIngredients) in possibleIngredientsByAllergen {
                    possibleIngredientsByAllergen[allergen] = possibleIngredients.removing(ingredient)
                }
                possibleIngredientsByAllergen[ingredientByAllergen.key] = nil
            }
        }
        
        let ingredientsSortedByAllergen = ingrediantsByAllergen.sorted(by: { element1, element2 in element2.key > element1.key }).map({ $0.value })
        
        print("\(ingredientsSortedByAllergen.joined(separator: ","))\n")
        return 0
    }
}
