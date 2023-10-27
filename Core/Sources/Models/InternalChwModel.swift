//
//  InternalChwModel.swift
//
//
//  Created by khushbu on 26/10/23.
//

import Foundation


public struct InternalChwModel: Codable {
    var id: String
    var name: String
    var isVolunteer: Bool = false
    var role: String
    var rolePermissions: [String]
    var siteIdsList: [String]
    var servicesList: [String]
    
    
    public  init(id: String, name: String, isVolunteer: Bool, role: String, rolePermissions: [String], siteIdsList: [String], servicesList: [String]) {
        self.id = id
        self.name = name
        self.isVolunteer = isVolunteer
        self.role = role
        self.rolePermissions = rolePermissions
        self.siteIdsList = siteIdsList
        self.servicesList = servicesList
    }
}
