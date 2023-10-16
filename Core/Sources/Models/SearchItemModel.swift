//
//  SearchItemModel.swift
//
//
//  Created by khushbu on 16/10/23.
//

import Foundation


public struct SearchItemModel: Codable {
    var item_id: String?
    var item_type: String?
    var facility_id: String?

    public init(item_id: String, item_type: String, facility_id: String = "") {
        self.item_id = item_id
        self.item_type = item_type
        self.facility_id = facility_id
    }

   
}

