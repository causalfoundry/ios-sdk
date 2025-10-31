//
//  PromoType.swift
//
//
//  Created by khushbu on 07/11/23.
//

import KenkaiSDKCore
import Foundation

public enum PromoType: String, EnumComposable {
    case AddToCart
    case Coupon
    case Other
    
    public var rawValue: String {
        switch self {
        case .AddToCart: return "add_to_cart"
        case .Coupon: return "coupon"
        case .Other: return "other"
        }
    }
    
}
