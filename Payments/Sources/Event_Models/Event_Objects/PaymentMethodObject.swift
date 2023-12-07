//
//  PaymentMethodObject.swift
//
//
//  Created by moizhassankh on 07/12/23.
//

import Foundation

public struct PaymentMethodObject: Codable {
    var paymentId: String = ""
    var orderId: String = ""
    var type: String = ""
    var action: String = ""
    var paymentAmount: Float?
    var currency: String = ""
    var meta: Encodable?

    enum CodingKeys: String, CodingKey {
        case paymentId = "id"
        case orderId = "order_id"
        case action
        case type
        case paymentAmount = "payment_amount"
        case currency
        case meta
    }

    init(paymentId: String, orderId: String, type: String, action: String, paymentAmount: Float, currency: String, meta: Encodable? = nil) {
        self.paymentId = paymentId
        self.orderId = orderId
        self.action = action
        self.type = type
        self.paymentAmount = paymentAmount
        self.currency = currency
        self.meta = meta
    }

    // Encoding method
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(paymentId, forKey: .paymentId)
        try container.encode(orderId, forKey: .orderId)
        try container.encode(type, forKey: .type)
        try container.encode(action, forKey: .action)
        try container.encode(paymentAmount, forKey: .paymentAmount)
        try container.encode(currency, forKey: .currency)
        if let metaData = meta {
            try container.encode(metaData, forKey: .meta)
        }
    }

    // Decoding method
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        paymentId = try container.decode(String.self, forKey: .paymentId)
        orderId = try container.decode(String.self, forKey: .orderId)
        type = try container.decode(String.self, forKey: .type)
        action = try container.decode(String.self, forKey: .action)
        paymentAmount = try container.decode(Float.self, forKey: .paymentAmount)
        currency = try container.decode(String.self, forKey: .currency)
        if let metaData = try container.decodeIfPresent(Data.self, forKey: .meta) {
            meta = try? (JSONSerialization.jsonObject(with: metaData, options: .allowFragments) as! any Encodable)
        } else {
            meta = nil
        }
    }
}
