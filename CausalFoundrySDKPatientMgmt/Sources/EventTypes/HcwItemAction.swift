//
//  ItemAction.swift
//
//
//  Created by khushbu on 26/10/23.
//

import CausalFoundrySDKCore
import Foundation

public enum HcwItemAction: String, EnumComposable {
    case View
    case Add
    case Update
    case Remove
    case Other
    
    public var rawValue: String {
        switch self {
        case .View: return "view"
        case .Add: return "add"
        case .Update: return "update"
        case .Remove: return "remove"
        case .Other: return "other"
        }
    }
    
}
