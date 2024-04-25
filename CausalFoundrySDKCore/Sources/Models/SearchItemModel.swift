//
//  SearchItemModel.swift
//
//
//  Created by khushbu on 16/10/23.
//

import Foundation

public struct SearchItemModel: Codable {
    var id: String?
    var type: String?
    var facilityId: String?

    public init(item_id: String, item_type: String, facilityId: String = "") {
        id = item_id
        type = item_type
        self.facilityId = facilityId
    }

    enum CodingKeys: String, CodingKey {
        case id
        case type
        case facilityId = "facility_id"
    }
}
