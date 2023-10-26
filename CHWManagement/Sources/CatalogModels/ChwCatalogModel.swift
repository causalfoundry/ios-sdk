//
//  ChwCatalogModel.swift
//
//
//  Created by khushbu on 26/10/23.
//

import Foundation



struct ChwCatalogModel: Codable {
    var name: String
    var role: String
    var isVolunteer: Bool
    var rolePermissions: [String]
    var siteIdsList: [String]
    var servicesList: [String]
    
    enum CodingKeys: String, CodingKey {
            case name
            case role
            case isVolunteer = "is_volunteer"
            case rolePermissions = "role_permissions_list"
            case siteIdsList = "site_ids_list"
            case servicesList = "services_list"
        }

}

