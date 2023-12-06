//
//  ItemReportObject.swift
//
//
//  Created by khushbu on 01/11/23.
//

import Foundation

public struct ItemReportObject : Codable {
    var item: ItemTypeModel
    var storeObject: StoreObject
    var reportObject: ReportObject
    var meta: Encodable?
    
    private enum CodingKeys: String, CodingKey {
        case item
        case storeObject = "store_info"
        case reportObject = "report_info"
        case meta
    }

    public init(item: ItemTypeModel, storeObject: StoreObject, reportObject: ReportObject, meta: Encodable? = nil) {
        self.item = item
        self.storeObject = storeObject
        self.reportObject = reportObject
        self.meta = meta
    }
    
    // Custom encoding method
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(item, forKey: .item)
        try container.encode(storeObject, forKey: .storeObject)
        try container.encode(reportObject, forKey: .reportObject)
        if let metaData = meta {
            try container.encode(metaData, forKey: .meta)
        }
    }

    // Custom decoding method
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        item = try container.decode(ItemTypeModel.self, forKey: .item)
        storeObject = try container.decode(StoreObject.self, forKey: .storeObject)
        reportObject = try container.decode(ReportObject.self, forKey: .reportObject)
        if let metaData = try? container.decodeIfPresent(Data.self, forKey: .meta) {
            meta = try? (JSONSerialization.jsonObject(with: metaData, options: .allowFragments) as! any Encodable)
        } else {
            meta = nil
        }
    }
    
}
