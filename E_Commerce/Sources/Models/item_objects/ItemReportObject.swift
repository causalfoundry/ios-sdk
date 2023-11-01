//
//  ItemReportObject.swift
//
//
//  Created by khushbu on 01/11/23.
//

import Foundation

public struct ItemReportObject {
    var item: ItemTypeModel
    var store_info: StoreObject
    var report_info: ReportObject
    var meta: Encodable?
    
    public  init(item: ItemTypeModel, store_info: StoreObject, report_info: ReportObject, meta: Encodable? = nil) {
        self.item = item
        self.store_info = store_info
        self.report_info = report_info
        self.meta = meta
    }
}

extension ItemReportObject: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(item, forKey: .item)
        try container.encode(store_info, forKey: .store_info)
        try container.encode(report_info, forKey: .report_info)
        if let metaData = meta {
            try container.encode(metaData, forKey: .meta)
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case item
        case store_info
        case report_info
        case meta
    }
}

extension ItemReportObject: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        item = try container.decode(ItemTypeModel.self, forKey: .item)
        store_info = try container.decode(StoreObject.self, forKey: .store_info)
        report_info = try container.decode(ReportObject.self, forKey: .report_info)
        if let metaData = try container.decodeIfPresent(Data.self, forKey: .meta) {
            meta = try? (JSONSerialization.jsonObject(with: metaData, options: .allowFragments) as! any Encodable)
        } else {
            meta = nil
        }
    }
}
