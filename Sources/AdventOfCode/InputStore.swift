//  InputStore.swift
//  AdventOfCode
//
//  Created by Dash on 12/1/20.
//

import Foundation

struct InputStore {
    private let cookieSession: String?
    
    init(cookieSession: String?) {
        self.cookieSession = cookieSession
        
        if let cookieSession = cookieSession {
            let cookie = HTTPCookie(properties: [
                .domain: ".adventofcode.com",
                .path: "/",
                .secure: "true",
                .name: "session",
                .value: cookieSession,
            ])!
            HTTPCookieStorage.shared.setCookie(cookie)
        }
    }
    
    func input(for puzzleIndex: Int, forceDownload: Bool) -> String {
        let filename = "Input/\(puzzleIndex).txt"
        if !forceDownload, let input = loadInput(fromFileNamed: filename) {
            print("Using cached input")
            return input
        } else {
            return downloadInput(for: puzzleIndex, toFileNamed: filename)
        }
    }
    
    private func loadInput(fromFileNamed filename: String) -> String? {
        let fileURL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath).appendingPathComponent(filename)
        do {
            return try String(contentsOf: fileURL)
        } catch {
            return nil
        }
    }
    
    private func downloadInput(for puzzleIndex: Int, toFileNamed filename: String) -> String {
        let inputURLString = "https://adventofcode.com/2020/day/\(puzzleIndex)/input"
        print("Downloading input from \(inputURLString)")
        
        let input: String
        do {
            try input = String(contentsOf: URL(string: inputURLString)!)
        } catch {
            fatalError("Download failed, cookie session: \(String(describing: cookieSession))")
        }
        
        if input.contains("Please log in to get your puzzle input.") {
            fatalError("Authentication failed, cookie session: \(String(describing: cookieSession))")
        }
        
        print("Downloaded \(input.lines.count) lines (\(input.count) chars) of input")
        
        let url = URL(fileURLWithPath: FileManager.default.currentDirectoryPath).appendingPathComponent(filename)
        do {
            try input.write(to: url, atomically: true, encoding: .utf8)
        } catch {
            fatalError("Could not write to file (\(url.relativePath))")
        }
        
        return input
    }
}
