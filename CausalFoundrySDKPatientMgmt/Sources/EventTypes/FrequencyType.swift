//
//  TreatmentFrequency.swift
//  
//
//  Created by MOIZ HASSAN KHAN on 26/4/24.
//

import CausalFoundrySDKCore
import Foundation

public enum FrequencyType: String, EnumComposable {
    case Daily
    case Days
    case Weeks
    case Months
    case Other
    
    public var rawValue: String {
        switch self {
        case .Daily: return "daily"
        case .Days: return "days"
        case .Weeks: return "weeks"
        case .Months: return "months"
        case .Other: return "other"
        }
    }
    
}
