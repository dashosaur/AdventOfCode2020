//  HTTPCookieStorage.swift
//  AdventOfCode
//
//  Created by Dash on 12/5/20.
//

import Foundation

extension HTTPCookieStorage {
    func configure(sessionCookie: String) {
        let cookie = HTTPCookie(properties: [
            .domain: ".adventofcode.com",
            .path: "/",
            .secure: "true",
            .name: "session",
            .value: sessionCookie,
        ])!
        HTTPCookieStorage.shared.setCookie(cookie)
    }
}
