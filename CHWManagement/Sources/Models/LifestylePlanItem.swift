//
//  File.swift
//  
//
//  Created by khushbu on 26/10/23.
//

import Foundation

public struct LifestylePlanItem: Codable {
    var name: String
    var action: String
    var remarks: String?
    
    init(name: String, action: String, remarks: String? = nil) {
        self.name = name
        self.action = action
        self.remarks = remarks
    }
}
