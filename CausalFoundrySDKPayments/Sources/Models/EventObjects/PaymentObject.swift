//
//  DeferredPaymentObject.swift
//
//
//  Created by moizhassankh on 07/12/23.
//

import CausalFoundrySDKCore
import Foundation

public struct PaymentObject: Codable {
    var paymentId: String
    var orderId: String
    var method: String
    var action: String
    var accountBalance: Double
    var paymentAmount: Double
    var currency: String
    var isSuccessful: Bool
    var meta: Encodable? = nil

    private enum CodingKeys: String, CodingKey {
        case paymentId = "id"
        case orderId = "order_id"
        case type
        case action
        case accountBalance = "account_balance"
        case paymentAmount = "payment_amount"
        case currency
        case isSuccessful = "is_successful"
        case meta
    }

    public init(paymentId: String, orderId: String, method: PaymentMethod, action: PaymentAction, currency: CurrencyCode, accountBalance: Double, paymentAmount: Double, isSuccessful: Bool, meta: Encodable? = nil) {
        self.paymentId = paymentId
        self.orderId = orderId
        self.method = method.rawValue
        self.action = action.rawValue
        self.accountBalance = accountBalance
        self.paymentAmount = paymentAmount
        self.currency = currency.rawValue
        self.isSuccessful = isSuccessful
        self.meta = meta
    }

    // Encoding to JSON
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(paymentId, forKey: .paymentId)
        try container.encode(orderId, forKey: .orderId)
        try container.encode(method, forKey: .type)
        try container.encode(action, forKey: .action)
        try container.encode(accountBalance, forKey: .accountBalance)
        try container.encode(paymentAmount, forKey: .paymentAmount)
        try container.encode(currency, forKey: .currency)
        try container.encode(isSuccessful, forKey: .isSuccessful)
        if let metaData = meta {
            try container.encodeIfPresent(metaData, forKey: .meta)
        }
    }

    // Decoding from JSON
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        paymentId = try container.decode(String.self, forKey: .paymentId)
        orderId = try container.decode(String.self, forKey: .orderId)
        method = try container.decode(String.self, forKey: .type)
        action = try container.decode(String.self, forKey: .action)
        accountBalance = try container.decode(Double.self, forKey: .accountBalance)
        paymentAmount = try container.decode(Double.self, forKey: .paymentAmount)
        currency = try container.decode(String.self, forKey: .currency)
        isSuccessful = try container.decode(Bool.self, forKey: .isSuccessful)
        if let metaData = try container.decodeIfPresent(Data.self, forKey: .meta) {
            meta = try? (JSONSerialization.jsonObject(with: metaData, options: .allowFragments) as! any Encodable)
        } else {
            meta = nil
        }
    }
}
