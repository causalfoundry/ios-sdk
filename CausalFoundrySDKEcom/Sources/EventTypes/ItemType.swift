//
//  ItemType.swift
//
//
//  Created by khushbu on 27/10/23.
//

import CausalFoundrySDKCore
import Foundation

public enum ItemType: String, EnumComposable {
    case Blood
    case Oxygen
    case Drug
    case MedicalEquipment
    case Grocery
    case Facility
    case Subscription
    case ItemVerification
    case ItemReport
    case Reward
    case Survey
    case Electronics
    case Clothing
    case Book
    case Misc
    
    public var rawValue: String {
        switch self {
        case .Blood: return "blood"
        case .Oxygen: return "oxygen"
        case .Drug: return "drug"
        case .MedicalEquipment: return "medical_equipment"
        case .Grocery: return "grocery"
        case .Facility: return "facility"
        case .Subscription: return "subscription"
        case .ItemVerification: return "item_verification"
        case .ItemReport: return "item_report"
        case .Reward: return "reward"
        case .Survey: return "survey"
        case .Electronics: return "electronics"
        case .Clothing: return "clothing"
        case .Book: return "book"
        case .Misc: return "misc"
        }
    }
}
