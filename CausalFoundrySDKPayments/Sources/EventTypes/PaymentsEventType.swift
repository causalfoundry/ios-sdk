//
//  PaymentsEventType.swift
//
//
//  Created by moizhassankh on 07/12/23.
//

import Foundation

public enum PaymentsEventType: String, CaseIterable, Codable {
    case DeferredPayment
    case PaymentMethod
    
    public var rawValue: String {
        switch self {
        case .DeferredPayment: return "deferred_payment"
        case .PaymentMethod: return "payment_method"
        }
    }
    
}
