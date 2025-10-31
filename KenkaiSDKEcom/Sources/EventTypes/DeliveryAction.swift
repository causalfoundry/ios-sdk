//
//  DeliveryAction.swift
//
//
//  Created by khushbu on 29/10/23.
//

import KenkaiSDKCore
import Foundation

public enum DeliveryAction: String, EnumComposable {
    case Schedule
    case Update
    case Dispatch
    case Delivered
    
    public var rawValue: String {
        switch self {
        case .Schedule: return "schedule"
        case .Update: return "update"
        case .Dispatch: return "dispatch"
        case .Delivered: return "delivered"
        }
    }
}
