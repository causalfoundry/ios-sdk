//
//  CancelType.swift
//
//
//  Created by khushbu on 01/11/23.
//

import CausalFoundrySDKCore
import Foundation

public enum CancelType: String, EnumComposable {
    case Cart
    case Order
    
    public var rawValue: String {
        switch self {
        case .Cart: return "cart"
        case .Order: return "order"
        }
    }
}
