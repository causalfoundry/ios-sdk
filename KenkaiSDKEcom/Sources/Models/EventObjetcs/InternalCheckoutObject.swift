//
//  InternalCheckoutObject.swift
//
//
//  Created by moizhassankh on 05/12/23.
//

import KenkaiSDKCore
import Foundation

internal struct InternalCheckoutObject: Codable {
    var orderId: String
    var cartId: String
    var isSuccessful: Bool
    var cartPrice: Float
    var shopMode: String
    var itemObject: ItemModel
    var meta: Encodable?

    private enum CodingKeys: String, CodingKey {
        case orderId = "id"
        case cartId  = "cart_id"
        case isSuccessful = "is_successful"
        case cartPrice  = "cart_price"
        case shopMode = "shop_mode"
        case item
        case meta
    }

    public init(orderId: String, cartId: String, isSuccessful: Bool, cartPrice: Float, shopMode: String, itemObject: ItemModel, meta: Encodable? = nil) {
        self.orderId = orderId
        self.cartId = cartId
        self.isSuccessful = isSuccessful
        self.cartPrice = cartPrice
        self.shopMode = shopMode
        self.itemObject = itemObject
        self.meta = meta
    }

    // Custom encoding method
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(orderId, forKey: .orderId)
        try container.encode(cartId, forKey: .cartId)
        try container.encode(isSuccessful, forKey: .isSuccessful)
        try container.encode(cartPrice, forKey: .cartPrice)
        try container.encode(shopMode, forKey: .shopMode)
        try container.encode(itemObject, forKey: .item)
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
        shopMode = try container.decode(String.self, forKey: .shopMode) // Decoding enum from rawValue
        itemObject = try container.decode(ItemModel.self, forKey: .item)
        if let metaData = try? container.decodeIfPresent(Data.self, forKey: .meta) {
            meta = try? (JSONSerialization.jsonObject(with: metaData, options: .allowFragments) as! any Encodable)
        } else {
            meta = nil
        }
        
    }
}
