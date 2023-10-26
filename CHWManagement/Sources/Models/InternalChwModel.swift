//
//  File 2.swift
//  
//
//  Created by khushbu on 26/10/23.
//

import Foundation


struct InternalChwModel: Codable {
    var id: String
    var name: String
    var isVolunteer: Bool
    var role: String
    var rolePermissions: [String]
    var siteIdsList: [String]
    var servicesList: [String]
}
