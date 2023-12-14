//
//  AppObject.swift
//
//
//  Created by khushbu on 17/09/23.
//

import Foundation

struct AppObject: Codable {
    var action: String?
    var start_time: Int?
    var meta: String?

    init(action: String, startTime: Int, meta: String) {
        self.action = action
        start_time = startTime
        self.meta = meta
    }
}
