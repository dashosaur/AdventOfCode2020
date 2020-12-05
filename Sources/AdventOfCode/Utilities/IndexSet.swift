//  IndexSet.swift
//  AdventOfCode
//
//  Created by Dash on 12/4/20.
//

import Foundation

extension IndexSet {
    init(indexes: [Int]) {
        self.init()
        for index in indexes {
            insert(index)
        }
    }
}
