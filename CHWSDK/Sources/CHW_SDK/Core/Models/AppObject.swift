//
//  File.swift
//  
//
//  Created by khushbu on 17/09/23.
//

import Foundation

struct AppObject {
    var action:String?
    var start_time:String?
    var meta:String?
    
    
    init(action:String, startTime: String, meta: String) {
        self.action = action
        self.start_time = startTime
        self.meta = meta
    }
}
