//
//  ChwSiteType.swift
//
//
//  Created by khushbu on 07/11/23.
//

import CausalFoundrySDKCore
import Foundation

public enum HcwSiteCategory: String, EnumComposable {
    case Facility
    case Community
    case PatientAddress
    case Virtual
    case Other

    
    public var rawValue: String {
        switch self {
        case .Facility: return "facility"
        case .Community: return "community"
        case .PatientAddress: return "patient_address"
        case .Virtual: return "virtual"
        case .Other: return "other"
        }
    }
    
}
