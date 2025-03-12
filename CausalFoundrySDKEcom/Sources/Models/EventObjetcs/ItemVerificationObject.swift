//
//  ItemVerificationObject.swift
//
//
//  Created by moizhassankh on 07/12/23.
//

import Foundation

public struct ItemVerificationObject: Codable {
    let scanChannel: String
    let scanType: String
    let isSuccessful: Bool
    let itemInfo: ItemInfoModel?
    let meta: Encodable?

    enum CodingKeys: String, CodingKey {
        case scanChannel = "scan_channel"
        case scanType = "scan_type"
        case isSuccessful = "is_successful"
        case itemInfo = "item_info"
        case meta
    }

    public init(scanChannel: ScanChannel, scanType: ScanType, isSuccessful: Bool, itemInfo: ItemInfoModel?, meta: Encodable? = nil) {
        self.scanChannel = scanChannel.rawValue
        self.scanType = scanType.rawValue
        self.isSuccessful = isSuccessful
        self.itemInfo = itemInfo
        self.meta = meta
    }

    // Custom encoding method
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(scanChannel, forKey: .scanChannel)
        try container.encode(scanType, forKey: .scanType)
        try container.encode(isSuccessful, forKey: .isSuccessful)
        try container.encodeIfPresent(itemInfo, forKey: .itemInfo)
        if let metaData = meta {
            try container.encode(metaData, forKey: .meta)
        }
    }

    // Custom decoding method
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        scanChannel = try container.decode(String.self, forKey: .scanChannel)
        scanType = try container.decode(String.self, forKey: .scanType)
        isSuccessful = try container.decode(Bool.self, forKey: .isSuccessful)
        itemInfo = try container.decodeIfPresent(ItemInfoModel.self, forKey: .itemInfo)
        if let metaData = try? container.decodeIfPresent(Data.self, forKey: .meta) {
            meta = try? (JSONSerialization.jsonObject(with: metaData, options: .allowFragments) as! any Encodable)
        } else {
            meta = nil
        }
    }
    
}
