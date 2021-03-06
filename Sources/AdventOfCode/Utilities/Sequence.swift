//  Collection.swift
//  AdventOfCode
//
//  Created by Dash on 12/2/20.
//

import Foundation

extension Sequence {
    func count(where predicate: (Element) -> Bool) -> Int {
        reduce(0) { predicate($1) ? $0 + 1 : $0 }
    }
    
    func reduceSum(_ valueForElement: (Element) -> Int) -> Int {
        reduce(0) { $0 + valueForElement($1) }
    }
    
    func reduceProduct(_ valueForElement: (Element) -> Int) -> Int {
        reduce(1) { $0 * valueForElement($1) }
    }
    
    func reduceMaximum(_ valueForElement: (Element) -> Int) -> Int {
        reduce(Int.min) {
            let value = valueForElement($1)
            return value > $0 ? value : $0
        }
    }
}

extension Array {
    public subscript(safe index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }

        return self[index]
    }
}

extension Set {
    func inserting(_ member: Element) -> Set {
        var copy = self
        copy.insert(member)
        return copy
    }
    
    func removing(_ member: Element) -> Set {
        var copy = self
        copy.remove(member)
        return copy
    }
}
