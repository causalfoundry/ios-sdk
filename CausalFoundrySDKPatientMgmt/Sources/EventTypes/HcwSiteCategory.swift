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
    case Other

    
    public var rawValue: String {
        switch self {
        case .Facility: return "facility"
        case .Community: return "community"
        case .PatientAddress: return "patient_address"
        case .Other: return "other"
        }
    }
    
}
