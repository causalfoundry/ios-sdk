//
//  ShopMode.swift
//
//
//  Created by khushbu on 02/11/23.
//

import KenkaiSDKCore
import Foundation

public enum ShopMode: String, EnumComposable {
    case Delivery
    case Pickup
    
    public var rawValue: String {
        switch self {
        case .Delivery: return "delivery"
        case .Pickup: return "pickup"
        }
    }
}
