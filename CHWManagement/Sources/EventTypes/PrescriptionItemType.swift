//
//  PrescriptionItemType.swift
//
//
//  Created by khushbu on 03/11/23.
//

import CausalFoundrySDKCore
import Foundation

import Foundation

public enum PrescriptionItemType: String, EnumComposable {
    case Tablet
    case Capsule
    case Syrup
    case Injection
    case Insulin
    case Other
    
    public var rawValue: String {
        switch self {
        case .Tablet: return "tablet"
        case .Capsule: return "capsule"
        case .Syrup: return "syrup"
        case .Injection: return "injection"
        case .Insulin: return "insulin"
        case .Other: return "other"
        }
    }
    
}
