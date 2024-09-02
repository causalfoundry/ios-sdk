//
//  File.swift
//  
//
//  Created by MOIZ HASSAN KHAN on 2/9/24.
//

import CausalFoundrySDKCore
import Foundation

public enum AppointmentStatus: String, EnumComposable {
    case Upcoming
    case Missed
    case Attended
    case Other
    
    public var rawValue: String {
        switch self {
        case .Upcoming: return "upcoming"
        case .Missed: return "missed"
        case .Attended: return "attended"
        case .Other: return "other"
        }
    }
    
}
