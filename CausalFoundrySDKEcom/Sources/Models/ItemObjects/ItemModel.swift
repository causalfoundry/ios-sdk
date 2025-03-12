//
//  ItemModel.swift
//
//
//  Created by khushbu on 27/10/23.
//

import CausalFoundrySDKCore
import Foundation

public struct ItemModel: Codable {
    var id: String
    var type: String
    var quantity: Int
    var price: Float
    var currency: String
    var stockStatus: String? = ""
    var promoId: String?  = ""
    var discount: Float? = 0
    var facilityId: String? = ""
    var subscription: SubscriptionObject? = nil
    var meta: Encodable?

    enum CodingKeys: String, CodingKey {
        case id
        case type
        case quantity
        case price
        case currency
        case stockStatus = "stock_status"
        case promoId = "promo_id"
        case discount
        case facilityId = "facility_id"
        case subscription
        case meta
    }
    public init(id: String, type: ItemType, quantity: Int, price: Float, currency: CurrencyCode,  stockStatus: ItemStockStatus? = ItemStockStatus.None, promoId: String? = "", discount: Float? = 0, facilityId: String? = "", subscription: SubscriptionObject? = nil, meta: Encodable? = nil) {
        self.id = id
        self.type = type.rawValue
        self.quantity = quantity
        self.price = price
        self.currency = currency.rawValue
        self.stockStatus = stockStatus?.rawValue
        self.promoId = promoId
        self.discount = discount
        self.facilityId = facilityId
        self.subscription = subscription
        self.meta = meta
    }

    // Custom encoding method
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(type, forKey: .type)
        try container.encode(quantity, forKey: .quantity)
        try container.encode(price, forKey: .price)
        try container.encode(currency, forKey: .currency)
        try container.encodeIfPresent(stockStatus, forKey: .stockStatus) // Encoding enum as rawValue
        try container.encodeIfPresent(promoId, forKey: .promoId)
        try container.encodeIfPresent(discount, forKey: .discount)
        try container.encodeIfPresent(facilityId, forKey: .facilityId)
        if let subscriptionData = subscription {
            try container.encodeIfPresent(subscriptionData, forKey: .subscription)
        }
        if let metaData = meta {
            try container.encodeIfPresent(metaData, forKey: .meta)
        }
        
    }

    // Custom decoding method
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        type = try container.decode(String.self, forKey: .type)
        quantity = try container.decode(Int.self, forKey: .quantity)
        price = try container.decode(Float.self, forKey: .price)
        currency = try container.decode(String.self, forKey: .currency)
        stockStatus = try container.decodeIfPresent(String.self, forKey: .stockStatus) // Decoding enum from rawValue
        promoId = try? container.decodeIfPresent(String.self, forKey: .promoId)
        discount = try? container.decodeIfPresent(Float.self, forKey: .discount)
        facilityId = try? container.decodeIfPresent(String.self, forKey: .facilityId)
        subscription = try? container.decodeIfPresent(SubscriptionObject.self, forKey: .subscription)
        if let metaString = try container.decodeIfPresent(String.self, forKey: .meta) {
            if(type == "blood"){
                let metaData = metaString.data(using: .utf8)!
                meta = try JSONDecoder().decode(BloodMetaModel.self, from: metaData)
            }else if (type == "oxygen"){
                let metaData = metaString.data(using: .utf8)!
                meta = try JSONDecoder().decode(OxygenMetaModel.self, from: metaData)
            }else{
                let metaData = metaString.data(using: .utf8)!
                meta = try? (JSONSerialization.jsonObject(with: metaData, options: .allowFragments) as! any Encodable)
            }
        } else {
            meta = nil
        }
        
    }
}

