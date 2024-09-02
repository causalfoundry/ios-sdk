//
//  HcwCatalogModel.swift
//
//
//  Created by MOIZ HASSAN KHAN on 01/05/24.
//

import Foundation

public struct HcwCatalogModel: Codable {
    var hcwId: String
    var name: String
    var role: String
    var siteIdList: [String]
    var supervisorIdList: [String]

    public enum CodingKeys: String, CodingKey {
        case hcwId = "id"
        case name
        case role
        case siteIdList = "site_id_list"
        case supervisorIdList = "supervisor_id_list"
    }

    public init(hcwId: String, name: String = "", role: String = "", siteIdList: [String] = [], supervisorIdList: [String] = []) {
        self.hcwId = hcwId
        self.name = name
        self.role = role
        self.siteIdList = siteIdList
        self.supervisorIdList = supervisorIdList
    }
}
