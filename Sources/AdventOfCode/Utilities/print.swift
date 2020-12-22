//  print.swift
//  AdventOfCode
//
//  Created by Dash on 12/21/20.
//

import Foundation

var enableVerbosePrints = true

func verbosePrint(_ items: Any...) {
    if enableVerbosePrints { print(items) }
}

func verbosePrint(_ string: String) {
    if enableVerbosePrints { print(string) }
}
