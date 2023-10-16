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
    var facility_id: String?

    public init(item_id: String, item_type: String, facility_id: String = "") {
        self.id = item_id
        self.type = item_type
        self.facility_id = facility_id
    }

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case type = "type"
        case facility_id = "facility_id"
   }
}

