//
//  RedeemType.swift
//
//
//  Created by khushbu on 08/11/23.
//

import CausalFoundrySDKCore
import Foundation

public enum RedeemType: String, EnumComposable {
    case Cash
    case Airtime
    case Other
    
    public var rawValue: String {
        switch self {
        case .Cash: return "cash"
        case .Airtime: return "airtime"
        case .Other: return "other"
        }
    }
}
