// swift-tools-version:5.2
//  Package.swift
//  AdventOfCode
//
//  Created by Dash on 12/2/20.
//

import PackageDescription

let package = Package(
    name: "AdventOfCode",
    platforms: [
       .macOS(.v10_15),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.3.0"),
    ],
    targets: [
        .target(name: "AdventOfCode", dependencies: [
            .product(name: "ArgumentParser", package: "swift-argument-parser"),
        ]),
    ]
)
