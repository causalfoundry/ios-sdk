//
//  CartAction.swift
//
//
//  Created by khushbu on 01/11/23.
//

import CausalFoundrySDKCore
import Foundation

public enum CartAction: String, EnumComposable {
    case AddItem
    case RemoveItem
    
    public var rawValue: String {
        switch self {
        case .AddItem: return "add_item"
        case .RemoveItem: return "remove_item"
        }
    }
}
