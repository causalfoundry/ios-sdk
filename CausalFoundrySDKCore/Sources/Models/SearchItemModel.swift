//
//  SearchItemModel.swift
//
//
//  Created by khushbu on 16/10/23.
//

import Foundation

public struct SearchItemModel: Codable {
    var id: String
    var type: String
    var facilityId: String?

    public init(itemId: String, itemType: SearchItemType, facilityId: String = "") {
        id = itemId
        type = itemType.rawValue
        self.facilityId = facilityId
    }

    enum CodingKeys: String, CodingKey {
        case id
        case type
        case facilityId = "facility_id"
    }
}
