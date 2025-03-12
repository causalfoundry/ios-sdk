//
//  ItemStockStatus.swift
//
//
//  Created by khushbu on 27/10/23.
//

import CausalFoundrySDKCore
import Foundation

public enum ItemStockStatus: String, EnumComposable {
    case InStock
    case LowStock
    case OutOfStock
    case None
    
    public var rawValue: String {
        switch self {
        case .InStock: return "in_stock"
        case .LowStock: return "low_stock"
        case .OutOfStock: return "out_of_stock"
        case .None: return ""
        }
    }
}
