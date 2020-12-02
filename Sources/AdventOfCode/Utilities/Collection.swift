//  Collection.swift
//  AdventOfCode
//
//  Created by Dash on 12/2/20.
//

import Foundation

extension Collection {
    func count(passing check: (Element) -> Bool) -> Int {
        reduce(0, { check($1) ? $0 + 1 : $0 })
    }
}
