//
//  HcwCatalogModel.swift
//
//
//  Created by MOIZ HASSAN KHAN on 01/05/24.
//

import Foundation

public struct HcwCatalogModel: Codable {
    var name: String
    var role: String
    var isVolunteer: Bool
    var rolePermissions: [String]
    var siteIdsList: [String]
    var servicesList: [String]

    public enum CodingKeys: String, CodingKey {
        case name
        case role
        case isVolunteer = "is_volunteer"
        case rolePermissions = "role_permissions_list"
        case siteIdsList = "site_ids_list"
        case servicesList = "services_list"
    }

    public init(name: String = "", role: String = "", isVolunteer: Bool = false, rolePermissions: [String] = [], siteIdsList: [String] = [], servicesList: [String] = []) {
        self.name = name
        self.role = role
        self.isVolunteer = isVolunteer
        self.rolePermissions = rolePermissions
        self.siteIdsList = siteIdsList
        self.servicesList = servicesList
    }
}
