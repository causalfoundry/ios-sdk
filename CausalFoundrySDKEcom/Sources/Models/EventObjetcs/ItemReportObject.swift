//
//  ItemReportObject.swift
//
//
//  Created by khushbu on 01/11/23.
//

import Foundation

public struct ItemReportObject : Codable {
    var itemId: String
    var itemType: String
    var reportId: String
    var reportRemarks: String
    var storeId: String
    var meta: Encodable?
    
    private enum CodingKeys: String, CodingKey {
        case itemId = "item_id"
        case itemType = "item_type"
        case reportId = "report_id"
        case reportRemarks = "report_remarks"
        case storeId = "store_id"
        case meta
    }

    public init(itemId: String, itemType: ItemType, reportId: String, reportRemarks: String, storeId: String, meta: Encodable? = nil) {
        self.itemId = itemId
        self.itemType = itemType.rawValue
        self.reportId = reportId
        self.reportRemarks = reportRemarks
        self.storeId = reportRemarks
        self.meta = meta
    }
    
    // Custom encoding method
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(itemId, forKey: .itemId)
        try container.encode(itemType, forKey: .itemType)
        try container.encode(reportId, forKey: .reportId)
        try container.encode(reportRemarks, forKey: .reportRemarks)
        try container.encode(storeId, forKey: .storeId)
        if let metaData = meta {
            try container.encode(metaData, forKey: .meta)
        }
    }

    // Custom decoding method
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        itemId = try container.decode(String.self, forKey: .itemId)
        itemType = try container.decode(String.self, forKey: .itemType)
        reportId = try container.decode(String.self, forKey: .reportId)
        reportRemarks = try container.decode(String.self, forKey: .reportRemarks)
        storeId = try container.decode(String.self, forKey: .storeId)
        if let metaData = try? container.decodeIfPresent(Data.self, forKey: .meta) {
            meta = try? (JSONSerialization.jsonObject(with: metaData, options: .allowFragments) as! any Encodable)
        } else {
            meta = nil
        }
    }
    
}
