//
//  SubscriptionType.swift
//  
//
//  Created by MOIZ HASSAN KHAN on 26/4/24.
//

import CausalFoundrySDKCore
import Foundation


public enum SubscriptionType: String, EnumComposable {
    case PayAsYouSell
    case PayAsYouGo
    case Other
    
    public var rawValue: String {
        switch self {
        case .PayAsYouSell: return "pay_as_you_sell"
        case .PayAsYouGo: return "pay_as_you_go"
        case .Other: return "other"
        }
    }
}
