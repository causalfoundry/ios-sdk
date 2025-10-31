//
//  ModuleLogAction.swift
//
//
//  Created by moizhassankh on 04/01/24.
//

import KenkaiSDKCore
import Foundation

public enum ModuleLogAction: String, EnumComposable {
    case View
    case Other
    
    public var rawValue: String {
        switch self {
        case .View: return "view"
        case .Other: return "other"
        }
    }
    
}
