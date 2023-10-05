//
//  IdentifyObject.swift
//
//
//  Created by khushbu on 05/10/23.
//

import Foundation


struct IdentifyObject:Codable {
    var action:String?
    
    init(action: String? = nil) {
        self.action = action
    }
}
