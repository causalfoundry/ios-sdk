//
//  File.swift
//  
//
//  Created by khushbu on 27/10/23.
//

import Foundation

struct ItemModel: Codable {
    var id: String
    var quantity: Int
    var price: Float
    var currency: String
    var type: String
    var stockStatus: ItemStockStatus
    var promoId: String
    var facilityId: String
    var meta: Any?

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

    // Custom encoding method
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys)
        try container.encode(id, forKey: .id)
        try container.encode(quantity, forKey: .quantity)
        try container.encode(price, forKey: .price)
        try container.encode(currency, forKey: .currency)
        try container.encode(type, forKey: .type)
        try container.encode(stockStatus.rawValue, forKey: .stockStatus) // Encoding enum as rawValue
        try container.encode(promoId, forKey: .promoId)
        try container.encode(facilityId, forKey: .facilityId)
        try container.encode(meta, forKey: .meta)
    }

    // Custom decoding method
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys)
        id = try container.decode(String.self, forKey: .id)
        quantity = try container.decode(Int.self, forKey: .quantity)
        price = try container.decode(Float.self, forKey: .price)
        currency = try container.decode(String.self, forKey: .currency)
        type = try container.decode(String.self, forKey: .type)
        let stockStatusRawValue = try container.decode(String.self, forKey: .stockStatus)
        stockStatus = ItemStockStatus(rawValue: stockStatusRawValue) ?? .outOfStock // Decoding enum from rawValue
        promoId = try container.decode(String.self, forKey: .promoId)
        facilityId = try container.decode(String.self, forKey: .facilityId)
        meta = try container.decode(Any?.self, forKey: .meta)
    }
}
