//  Collection.swift
//  AdventOfCode
//
//  Created by Dash on 12/2/20.
//

import Foundation

extension Sequence {
    func count(passing check: (Element) -> Bool) -> Int {
        reduce(0, { check($1) ? $0 + 1 : $0 })
    }
    
    func reduceSum(_ valueForElement: (Element) -> Int) -> Int {
        reduce(0, { $0 + valueForElement($1) })
    }
    
    func reduceProduct(_ valueForElement: (Element) -> Int) -> Int {
        reduce(1, { $0 * valueForElement($1) })
    }
    
    func reduceMaximum(_ valueForElement: (Element) -> Int) -> Int {
        reduce(Int.min, {
            let value = valueForElement($1)
            return value > $0 ? value : $0
        })
    }
}
