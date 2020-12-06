//  Leaderboard.swift
//  AdventOfCode
//
//  Created by Dash on 12/5/20.
//

import Foundation

struct Leaderboard {
    let ID: Int
    
    struct User {
        let ID: Int
        let name: String
        let localScore: Int
        let globalScore: Int
        let stars: Int
        
        init(ID: Int, jsonDictionary: Dictionary<String, Any>) {
            self.ID = ID
            self.name = jsonDictionary["name"] as! String
            self.localScore = jsonDictionary["local_score"] as! Int
            self.globalScore = jsonDictionary["global_score"] as! Int
            self.stars = jsonDictionary["stars"] as! Int
        }
        
        func printStatistics() {
            let scoreText = "\(localScore) (\(globalScore) global)"
            print("\(name.padding())\(scoreText.padding())\("\(stars)".padding())")
        }
    }
    
    struct PuzzleResult {
        let puzzleIndex: Int
        var part1DateByUserID: [Int : Date] = [:]
        var part2DateByUserID: [Int : Date] = [:]
        
        func printStatistics(users: [User]) {
            let header = "\("Day \(puzzleIndex)".padding())\("Part 1".padding())\("Part 2".padding())"
            print("\n\(header.bold().cyan())")
            
            let sortedUsers = users.sorted(by: {
                if let part2Date0 = part2DateByUserID[$0.ID], let part2Date1 = part2DateByUserID[$1.ID] {
                    return part2Date0 < part2Date1
                } else {
                    return part1DateByUserID[$0.ID] ?? Date.distantFuture < part1DateByUserID[$1.ID] ?? Date.distantFuture
                }
            })
            
            for user in sortedUsers {
                let part1Completion = part1DateByUserID[user.ID]
                let part2Completion = part2DateByUserID[user.ID]
                print("\(user.name.padding())\(DateFormatter.completion.completionString(from: part1Completion))\(DateFormatter.completion.completionString(from: part2Completion))")
            }
        }
    }
    
    func printStatistics(puzzleIndex: Int?) {
        do {
            let leaderboardData = try Data(contentsOf: URL(string: "https://adventofcode.com/2020/leaderboard/private/view/\(ID).json")!)
            let leaderboardJSON = try (JSONSerialization.jsonObject(with: leaderboardData, options: []) as! Dictionary<String, Any>)
            guard let membersJSON = leaderboardJSON["members"] as? Dictionary<String, Any> else { return }
            
            var users: [User] = []
            var puzzleResultsByIndex: [Int : PuzzleResult] = [:]
            
            for (userID, userJSON) in membersJSON {
                let userJSONDictionary = userJSON as! Dictionary<String, Any>
                let user = User(ID: Int(userID)!, jsonDictionary: userJSONDictionary)
                users.append(user)
                
                let times = userJSONDictionary["completion_day_level"] as! Dictionary<String, Dictionary<String, Dictionary<String, String>>>
                for (indexString, dictionary) in times {
                    let index = Int(indexString)!
                    var result = puzzleResultsByIndex[index] ?? PuzzleResult(puzzleIndex: Int(indexString)!)
                    result.part1DateByUserID[user.ID] = dictionary["1"].map { Date(timeIntervalSince1970: Double($0["get_star_ts"]!)!) }
                    result.part2DateByUserID[user.ID] = dictionary["2"].map { Date(timeIntervalSince1970: Double($0["get_star_ts"]!)!) }
                    puzzleResultsByIndex[index] = result
                }
            }
            
            if let puzzleIndex = puzzleIndex, let puzzleResult = puzzleResultsByIndex[puzzleIndex] {
                puzzleResult.printStatistics(users: users)
            } else {
                print("\n\("Users".padding().bold().cyan())\("Score".padding().bold().cyan())\("Stars".padding().bold().cyan())")
                let sortedUsers = users.sorted(by: { $0.localScore > $1.localScore })
                for user in sortedUsers {
                    user.printStatistics()
                }
                
                for index in puzzleResultsByIndex.keys.sorted() {
                    puzzleResultsByIndex[index]!.printStatistics(users: users)
                }
            }
        } catch {
            print("error")
        }
    }
}

fileprivate extension DateFormatter {
    static let completion: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "M/dd, h:mm:ss a"
        return formatter
    }()
    
    func completionString(from date: Date?) -> String {
        if let date = date {
            return string(from: date).padding()
        } else {
            return "Not Yet".padding().gray()
        }
    }
}

extension String {
    func padding() -> String {
        padding(toLength:22, withPad: " ", startingAt: 0)
    }
    
    func bold() -> String {
        "\u{001B}[1m\(self)\u{001B}[22m"
    }
    
    func gray() -> String {
        "\u{001B}[37m\(self)\u{001B}[0m"
    }
    
    func cyan() -> String {
        "\u{001B}[36m\(self)\u{001B}[0m"
    }
    
    func pink() -> String {
        "\u{001B}[35m\(self)\u{001B}[0m"
    }
}
