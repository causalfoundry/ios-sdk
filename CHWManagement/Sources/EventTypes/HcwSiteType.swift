//
//  ChwSiteType.swift
//
//
//  Created by khushbu on 07/11/23.
//

import CausalFoundrySDKCore
import Foundation

public enum HcwSiteType: String, EnumComposable {
    case Facility
    case Community
    case Other

    
    public var rawValue: String {
        switch self {
        case .Facility: return "facility"
        case .Community: return "community"
        case .Other: return "other"
        }
    }
    
}
