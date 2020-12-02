//  Date.swift
//  AdventOfCode
//
//  Created by Dash on 12/2/20.
//

import Foundation

extension Date {
    var milisecondsAgo: Int {
        Int(Date().timeIntervalSince(self) * 1000)
    }
}
