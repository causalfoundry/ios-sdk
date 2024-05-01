//
//  InternalHcwModel.swift
//
//
//  Created by MOIZ HASSAN KHAN on 01/05/24.
//

import Foundation

struct InternalHcwModel: Codable {
    var id: String
    var name: String
    var isVolunteer: Bool
    var role: String
    var rolePermissions: [String]
    var siteIdsList: [String]
    var servicesList: [String]
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case role
        case isVolunteer = "is_volunteer"
        case rolePermissions = "role_permissions_list"
        case siteIdsList = "site_ids_list"
        case servicesList = "services_list"
    }

    init(id: String, name: String = "", isVolunteer: Bool = false, role: String = "", rolePermissions: [String] = [], siteIdsList: [String] = [], servicesList: [String] = []) {
        self.id = id
        self.name = name
        self.isVolunteer = isVolunteer
        self.role = role
        self.rolePermissions = rolePermissions
        self.siteIdsList = siteIdsList
        self.servicesList = servicesList
    }
}
