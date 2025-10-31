//
//  File.swift
//  
//
//  Created by MOIZ HASSAN KHAN on 2/9/24.
//

import KenkaiSDKCore
import Foundation

public enum AppointmentFollowupType: String, EnumComposable {
    case PhoneCall
    case SMS
    case WhatsApp
    case HouseVisit
    case Other
    
    public var rawValue: String {
        switch self {
        case .PhoneCall: return "phone_call"
        case .SMS: return "sms"
        case .WhatsApp: return "whatsapp"
        case .HouseVisit: return "house_visit"
        case .Other: return "other"
        }
    }
    
}
