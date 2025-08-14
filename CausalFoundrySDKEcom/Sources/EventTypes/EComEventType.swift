//
//  EComEventType.swift
//
//
//  Created by khushbu on 27/10/23.
//

import Foundation

public enum EComEventType: String, CaseIterable, Codable {
    case Item
    case Delivery
    case Checkout
    case Cart
    case CancelCheckout
    case ItemReport
    case ItemRequest
    
    public var rawValue: String {
        switch self {
        case .Item: return "item"
        case .Delivery: return "delivery"
        case .Checkout: return "checkout"
        case .Cart: return "cart"
        case .CancelCheckout: return "cancel_checkout"
        case .ItemReport: return "item_report"
        case .ItemRequest: return "item_request"
        }
    }
    
}
