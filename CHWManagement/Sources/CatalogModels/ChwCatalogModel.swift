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
}

