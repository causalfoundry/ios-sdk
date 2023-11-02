//
//  DeferredPaymentObject.swift
//
//
//  Created by khushbu on 02/11/23.

import Foundation

public struct DeferredPaymentObject: Codable {
    var paymentId: String
    var orderId: String
    var type: String
    var action: String?
    var accountBalance: Float?
    var paymentAmount: Float?
    var currency: String?
    var isSuccessful: Bool?
    var usdRate: Float?
    var meta: Encodable?
    
    enum CodingKeys: String, CodingKey {
        case paymentId = "id"
        case orderId = "order_id"
        case type
        case action
        case accountBalance
        case paymentAmount
        case currency
        case isSuccessful
        case usdRate
        case meta
    }
    
    public init(paymentId: String, orderId: String, type: String, action: String?, accountBalance: Float?, paymentAmount: Float?, currency: String?, isSuccessful: Bool?, usdRate: Float?, meta: Encodable?) {
        self.paymentId = paymentId
        self.orderId = orderId
        self.type = type
        self.action = action
        self.accountBalance = accountBalance
        self.paymentAmount = paymentAmount
        self.currency = currency
        self.isSuccessful = isSuccessful
        self.usdRate = usdRate
        self.meta = meta
    }
    
    // Encoding to JSON
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(paymentId, forKey: .paymentId)
        try container.encode(orderId, forKey: .orderId)
        try container.encode(type, forKey: .type)
        try container.encodeIfPresent(action, forKey: .action)
        try container.encodeIfPresent(accountBalance, forKey: .accountBalance)
        try container.encodeIfPresent(paymentAmount, forKey: .paymentAmount)
        try container.encodeIfPresent(currency, forKey: .currency)
        try container.encodeIfPresent(isSuccessful, forKey: .isSuccessful)
        try container.encodeIfPresent(usdRate, forKey: .usdRate)
        if let metaData = meta {
            try container.encode(metaData, forKey: .meta)
        }
        
    }
    
    // Decoding from JSON
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        paymentId = try container.decode(String.self, forKey: .paymentId)
        orderId = try container.decode(String.self, forKey: .orderId)
        type = try container.decode(String.self, forKey: .type)
        action = try container.decodeIfPresent(String.self, forKey: .action)
        accountBalance = try container.decodeIfPresent(Float.self, forKey: .accountBalance)
        paymentAmount = try container.decodeIfPresent(Float.self, forKey: .paymentAmount)
        currency = try container.decodeIfPresent(String.self, forKey: .currency)
        isSuccessful = try container.decodeIfPresent(Bool.self, forKey: .isSuccessful)
        usdRate = try container.decodeIfPresent(Float.self, forKey: .usdRate)
        if let metaData = try container.decodeIfPresent(Data.self, forKey: .meta) {
            meta = try? (JSONSerialization.jsonObject(with: metaData, options: .allowFragments) as! any Encodable)
        } else {
            meta = nil
        }
        
    }
}
