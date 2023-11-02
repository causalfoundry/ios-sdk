//
//  File.swift
//
//
//  Created by khushbu on 02/11/23.
//

import Foundation

public struct CheckoutObject: Codable {
    var order_id: String
    var cart_id: String
    var is_successful: Bool
    var cart_price: Float?
    var currency: String?
    var shopMode: String?
    var items: [ItemModel]
    var usd_rate: Float?
    var meta: Encodable?
    
    enum CodingKeys: String, CodingKey {
        case order_id = "id"
        case cart_id
        case is_successful
        case cart_price
        case currency
        case shopMode = "shop_mode"
        case items
        case usd_rate
        case meta
    }
    
   public init(order_id: String, cart_id: String, is_successful: Bool, cart_price: Float? = nil, currency: String? = nil, shopMode: String? = nil, items: [ItemModel], usd_rate: Float? = nil, meta: Encodable? = nil) {
        self.order_id = order_id
        self.cart_id = cart_id
        self.is_successful = is_successful
        self.cart_price = cart_price
        self.currency = currency
        self.shopMode = shopMode
        self.items = items
        self.usd_rate = usd_rate
        self.meta = meta
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.order_id = try container.decode(String.self, forKey: .order_id)
        self.cart_id = try container.decode(String.self, forKey: .cart_id)
        self.is_successful = try container.decode(Bool.self, forKey: .is_successful)
        self.cart_price = try container.decodeIfPresent(Float.self, forKey: .cart_price)
        self.currency = try container.decodeIfPresent(String.self, forKey: .currency)
        self.shopMode = try container.decodeIfPresent(String.self, forKey: .shopMode)
        self.items = try container.decode([ItemModel].self, forKey: .items)
        self.usd_rate = try container.decodeIfPresent(Float.self, forKey: .usd_rate)
        if let metaData = try container.decodeIfPresent(Data.self, forKey: .meta) {
            meta = try? (JSONSerialization.jsonObject(with: metaData, options: .allowFragments) as! any Encodable)
        } else {
            meta = nil
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(order_id, forKey: .order_id)
        try container.encode(cart_id, forKey: .cart_id)
        try container.encode(is_successful, forKey: .is_successful)
        try container.encode(cart_price, forKey: .cart_price)
        try container.encode(currency, forKey: .currency)
        try container.encode(shopMode, forKey: .shopMode)
        try container.encode(items, forKey: .items)
        try container.encode(usd_rate, forKey: .usd_rate)
        if let metaData = meta {
            try container.encode(metaData, forKey: .meta)
        }
        
    }
}

