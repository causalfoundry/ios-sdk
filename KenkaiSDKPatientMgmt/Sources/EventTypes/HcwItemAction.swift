//
//  ItemAction.swift
//
//
//  Created by khushbu on 26/10/23.
//

import KenkaiSDKCore
import Foundation

public enum HcwItemAction: String, EnumComposable {
    case View
    case Add
    case Update
    case Done
    case Remove
    case Other
    
    public var rawValue: String {
        switch self {
        case .View: return "view"
        case .Add: return "add"
        case .Update: return "update"
        case .Done: return "done"
        case .Remove: return "remove"
        case .Other: return "other"
        }
    }
    
}
