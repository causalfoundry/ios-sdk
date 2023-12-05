//
//  ItemModel.swift
//
//
//  Created by khushbu on 27/10/23.
//

import Foundation

public struct ItemModel: Codable {
    var id: String?
    var quantity: Int?
    var price: Float?
    var currency: String?
    var type: String?
    var stockStatus: String?
    var promoId: String?
    var facilityId: String?
    var meta: Encodable?

    enum CodingKeys: String, CodingKey {
        case id
        case quantity
        case price
        case currency
        case type
        case stockStatus = "stock_status"
        case promoId = "promo_id"
        case facilityId = "facility_id"
        case meta
    }

    public init(id: String?, quantity: Int, price: Float, currency: String?, type: String?, stockStatus: String?, promoId: String?, facilityId: String?, meta: Encodable? = nil) {
        self.id = id
        self.quantity = quantity
        self.price = price
        self.currency = currency
        self.type = type
        self.stockStatus = stockStatus
        self.promoId = promoId
        self.facilityId = facilityId
        self.meta = meta
    }

    // Custom encoding method
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(quantity, forKey: .quantity)
        try container.encode(price, forKey: .price)
        try container.encode(currency, forKey: .currency)
        try container.encode(type, forKey: .type)
        try container.encode(stockStatus, forKey: .stockStatus) // Encoding enum as rawValue
        try container.encode(promoId, forKey: .promoId)
        try container.encode(facilityId, forKey: .facilityId)
        if let metaData = meta {
            try container.encode(metaData, forKey: .meta)
        }
    }

    // Custom decoding method
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        quantity = try container.decode(Int.self, forKey: .quantity)
        price = try container.decode(Float.self, forKey: .price)
        currency = try container.decode(String.self, forKey: .currency)
        type = try container.decode(String.self, forKey: .type)
        stockStatus = try container.decode(String.self, forKey: .stockStatus) // Decoding enum from rawValue
        promoId = try container.decode(String.self, forKey: .promoId)
        facilityId = try container.decode(String.self, forKey: .facilityId)
        if let metaData = try container.decodeIfPresent(Data.self, forKey: .meta) {
            meta = try? (JSONSerialization.jsonObject(with: metaData, options: .allowFragments) as! any Encodable)
        } else {
            meta = nil
        }
    }
}
