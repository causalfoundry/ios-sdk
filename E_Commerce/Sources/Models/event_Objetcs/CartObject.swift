//
//  CartObject.swift
//
//
//  Created by khushbu on 01/11/23.
//

import Foundation

public struct CartObject: Codable {
    var cartId: String?
    var action: String?
    var item: ItemModel
    var cartPrice: Float
    var currency: String
    var usdRate: Float?
    var meta: Encodable?

    enum CodingKeys: String, CodingKey {
        case cartId = "id"
        case action
        case item
        case cartPrice = "cart_price"
        case currency
        case usdRate = "_usd_rate"
        case meta
    }

    public init(cartId: String? = nil, action: String? = nil, item: ItemModel, cartPrice: Float, currency: String, usdRate: Float? = nil, meta: Encodable? = nil) {
        self.cartId = cartId
        self.action = action
        self.item = item
        self.cartPrice = cartPrice
        self.currency = currency
        self.usdRate = usdRate
        self.meta = meta
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        cartId = try container.decodeIfPresent(String.self, forKey: .cartId)
        action = try container.decodeIfPresent(String.self, forKey: .action)
        item = try container.decode(ItemModel.self, forKey: .item)
        cartPrice = try container.decode(Float.self, forKey: .cartPrice)
        currency = try container.decode(String.self, forKey: .currency)
        usdRate = try container.decodeIfPresent(Float.self, forKey: .usdRate)
        if let metaData = try container.decodeIfPresent(Data.self, forKey: .meta) {
            meta = try? (JSONSerialization.jsonObject(with: metaData, options: .allowFragments) as! any Encodable)
        } else {
            meta = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(cartId, forKey: .cartId)
        try container.encode(action, forKey: .action)
        try container.encode(item, forKey: .item)
        try container.encode(cartPrice, forKey: .cartPrice)
        try container.encode(currency, forKey: .currency)
        try container.encode(usdRate, forKey: .usdRate)
        if let metaData = meta {
            try container.encode(metaData, forKey: .meta)
        }
    }
}
