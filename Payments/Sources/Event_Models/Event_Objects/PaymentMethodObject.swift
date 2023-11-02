//
//  File.swift
//
//
//  Created by khushbu on 02/11/23.
//

import Foundation


public struct PaymentMethodObject: Codable {
    var order_id: String?
    var type: String?
    var payment_amount: Float?
    var currency: String?
    var usd_rate: Float?
    var meta: Encodable?
    
    enum CodingKeys: String, CodingKey {
        case order_id
        case type
        case payment_amount
        case currency
        case usd_rate
        case meta
    }
    
    init(order_id: String, type: String, payment_amount: Float, currency: String? = nil, usd_rate: Float? = nil, meta: Encodable? = nil) {
        self.order_id = order_id
        self.type = type
        self.payment_amount = payment_amount
        self.currency = currency
        self.usd_rate = usd_rate
        self.meta = meta
    }
    // Encoding method
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(order_id, forKey: .order_id)
        try container.encode(type, forKey: .type)
        try container.encode(payment_amount, forKey: .payment_amount)
        try container.encode(currency, forKey: .currency)
        try container.encodeIfPresent(usd_rate, forKey: .usd_rate)
        if let metaData = meta {
            try container.encode(metaData, forKey: .meta)
        }
        
    }
    
    // Decoding method
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        order_id = try container.decode(String.self, forKey: .order_id)
        type = try container.decode(String.self, forKey: .type)
        payment_amount = try container.decode(Float.self, forKey: .payment_amount)
        currency = try container.decodeIfPresent(String.self, forKey: .currency)
        usd_rate = try container.decodeIfPresent(Float.self, forKey: .usd_rate)
        if let metaData = try container.decodeIfPresent(Data.self, forKey: .meta) {
            meta = try? (JSONSerialization.jsonObject(with: metaData, options: .allowFragments) as! any Encodable)
        } else {
            meta = nil
        }
        
    }
}
