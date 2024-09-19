//
//  HcwCatalogModel.swift
//
//
//  Created by MOIZ HASSAN KHAN on 01/05/24.
//

import Foundation

public struct HcwCatalogModel: Codable {
    var hcwId: String
    var name: String?
    var role: String?
    var siteIdList: [String]?
    var supervisorIdList: [String]?

    public enum CodingKeys: String, CodingKey {
        case hcwId = "id"
        case name
        case role
        case siteIdList = "site_id_list"
        case supervisorIdList = "supervisor_id_list"
    }

    public init(hcwId: String, name: String? = "", role: String? = "", siteIdList: [String]? = [], supervisorIdList: [String]? = []) {
        self.hcwId = hcwId
        self.name = name
        self.role = role
        self.siteIdList = siteIdList
        self.supervisorIdList = supervisorIdList
    }
    
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(hcwId, forKey: .hcwId)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(role, forKey: .role)
        try container.encodeIfPresent(siteIdList, forKey: .siteIdList)
        try container.encodeIfPresent(supervisorIdList, forKey: .supervisorIdList)
        
    }

    // Decoding
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        hcwId = try container.decode(String.self, forKey: .hcwId)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        role = try container.decodeIfPresent(String.self, forKey: .role)
        siteIdList = try container.decodeIfPresent([String].self, forKey: .siteIdList)
        supervisorIdList = try container.decodeIfPresent([String].self, forKey: .supervisorIdList)
    }

    
    
}

