//
//  CheckoutObject.swift
//
//
//  Created by moizhassankh on 05/12/23.
//

import Foundation

public struct CheckoutObject: Codable {
    var orderId: String
    var cartId: String
    var isSuccessful: Bool
    var cartPrice: Float
    var currency: String
    var shopMode: String
    var itemList: [ItemModel]
    var meta: Encodable?

    enum CodingKeys: String, CodingKey {
        case orderId = "id"
        case cartId  = "cart_id"
        case isSuccessful = "is_successful"
        case cartPrice  = "cart_price"
        case currency
        case shopMode = "shop_mode"
        case itemList = "items"
        case meta
    }

    public init(orderId: String, cartId: String, isSuccessful: Bool, cartPrice: Float, currency: String, shopMode: String, itemList: [ItemModel], meta: Encodable? = nil) {
        self.orderId = orderId
        self.cartId = cartId
        self.isSuccessful = isSuccessful
        self.cartPrice = cartPrice
        self.currency = currency
        self.shopMode = shopMode
        self.itemList = itemList
        self.meta = meta
    }

    // Custom encoding method
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(orderId, forKey: .orderId)
        try container.encode(cartId, forKey: .cartId)
        try container.encode(isSuccessful, forKey: .isSuccessful)
        try container.encode(cartPrice, forKey: .cartPrice)
        try container.encode(currency, forKey: .currency)
        try container.encode(shopMode, forKey: .shopMode)
        try container.encode(itemList, forKey: .itemList)
        if let metaData = meta {
            try container.encode(metaData, forKey: .meta)
        }
        
    }

    // Custom decoding method
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        orderId = try container.decode(String.self, forKey: .orderId)
        cartId = try container.decode(String.self, forKey: .cartId)
        isSuccessful = try container.decode(Bool.self, forKey: .isSuccessful)
        cartPrice = try container.decode(Float.self, forKey: .cartPrice)
        currency = try container.decode(String.self, forKey: .currency)
        shopMode = try container.decode(String.self, forKey: .shopMode) // Decoding enum from rawValue
        itemList = try container.decode([ItemModel].self, forKey: .itemList)
        if let metaData = try? container.decodeIfPresent(Data.self, forKey: .meta) {
            meta = try? (JSONSerialization.jsonObject(with: metaData, options: .allowFragments) as! any Encodable)
        } else {
            meta = nil
        }
        
    }
}
