//
//  HcwCatalogModel.swift
//
//
//  Created by MOIZ HASSAN KHAN on 01/05/24.
//

import Foundation

public struct HcwCatalogModel: Codable {
    var name: String?
    var role: String
    var siteIdList: [String]?
    var supervisorIdList: [String]?

    public enum CodingKeys: String, CodingKey {
        case name
        case role
        case siteIdList = "site_id_list"
        case supervisorIdList = "supervisor_id_list"
    }

    public init(role: String, name: String? = "", siteIdList: [String]? = [], supervisorIdList: [String]? = []) {
        self.name = name
        self.role = role
        self.siteIdList = siteIdList
        self.supervisorIdList = supervisorIdList
    }
    
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encode(role, forKey: .role)
        try container.encodeIfPresent(siteIdList, forKey: .siteIdList)
        try container.encodeIfPresent(supervisorIdList, forKey: .supervisorIdList)
        
    }

    // Decoding
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        role = try container.decode(String.self, forKey: .role)
        siteIdList = try container.decodeIfPresent([String].self, forKey: .siteIdList)
        supervisorIdList = try container.decodeIfPresent([String].self, forKey: .supervisorIdList)
    }

    
    
}

