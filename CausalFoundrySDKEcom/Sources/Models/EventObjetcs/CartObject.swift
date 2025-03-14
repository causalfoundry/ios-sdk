//
//  CartObject.swift
//
//
//  Created by moizhassankh on 05/12/23.
//
import CausalFoundrySDKCore
import Foundation

public struct CartObject: Codable {
    var cartId: String
    var action: String
    var item: ItemModel
    var cartPrice: Float
    var currency: String
    var meta: Encodable?

    private enum CodingKeys: String, CodingKey {
        case cartId = "id"
        case action
        case item
        case cartPrice = "cart_price"
        case currency
        case meta
    }

    public init(cartId: String, action: CartAction, item: ItemModel, cartPrice: Float, currency: CurrencyCode, meta: Encodable? = nil) {
        self.cartId = cartId
        self.action = action.rawValue
        self.item = item
        self.cartPrice = cartPrice
        self.currency = currency.rawValue
        self.meta = meta
    }
    
    // Custom encoding method
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(cartId, forKey: .cartId)
        try container.encode(action, forKey: .action)
        try container.encode(item, forKey: .item)
        try container.encode(cartPrice, forKey: .cartPrice)
        try container.encode(currency, forKey: .currency)
        if let metaData = meta {
            try container.encode(metaData, forKey: .meta)
        }
        
    }

    // Custom decoding method
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        cartId = try container.decode(String.self, forKey: .cartId)
        action = try container.decode(String.self, forKey: .action)
        item = try container.decode(ItemModel.self, forKey: .item)
        cartPrice = try container.decode(Float.self, forKey: .cartPrice)
        currency = try container.decode(String.self, forKey: .currency)
        if let metaData = try? container.decodeIfPresent(Data.self, forKey: .meta) {
            meta = try? (JSONSerialization.jsonObject(with: metaData, options: .allowFragments) as! any Encodable)
        } else {
            meta = nil
        }
        
    }
    
}
