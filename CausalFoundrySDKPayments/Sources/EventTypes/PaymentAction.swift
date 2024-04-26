//
//  PaymentAction.swift
//
//
//  Created by moizhassankh on 07/12/23.
//
import CausalFoundrySDKCore
import Foundation

public enum PaymentAction: String, EnumComposable {
    case View
    case Add
    case Remove
    case Update
    case Select
    case PaymentProcessed
    case Other
    
    public var rawValue: String {
        switch self {
        case .View: return "view"
        case .Add: return "add"
        case .Remove: return "remove"
        case .Update: return "update"
        case .Select: return "select"
        case .PaymentProcessed: return "payment_processed"
        case .Other: return "other"
        }
    }
    
}
