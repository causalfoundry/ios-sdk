//
//  PromoAction.swift
//
//
//  Created by khushbu on 07/11/23.
//

import CausalFoundrySDKCore
import Foundation

public enum PromoAction: String, EnumComposable {
    case View
    case Apply
    case Other
    
    public var rawValue: String {
        switch self {
        case .View: return "view"
        case .Apply: return "apply"
        case .Other: return "other"
        }
    }
}
