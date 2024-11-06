//
//  PrescriptionFormulationType.swift
//
//
//  Created by Moiz Hassan Khan on 06/11/24.
//

import CausalFoundrySDKCore
import Foundation

import Foundation

public enum PrescriptionFormulationType: String, EnumComposable {
    case Tablet
    case Capsule
    case Syrup
    case Injection
    case Insulin
    case Contraceptive
    case Other
    
    public var rawValue: String {
        switch self {
        case .Tablet: return "tablet"
        case .Capsule: return "capsule"
        case .Syrup: return "syrup"
        case .Injection: return "injection"
        case .Insulin: return "insulin"
        case .Contraceptive: return "contraceptive"
        case .Other: return "other"
        }
    }
    
}
