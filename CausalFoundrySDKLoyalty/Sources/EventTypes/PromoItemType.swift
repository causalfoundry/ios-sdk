//
//  PromoItemType.swift
//
//
//  Created by khushbu on 08/11/23.
//

import CausalFoundrySDKCore
import Foundation

public enum PromoItemType: String, EnumComposable {
    case Blood
    case Oxygen
    case Drug
    case MedicalEquipment
    case Grocery
    case Facility
    case Subscription
    case Electronics
    case Clothing
    case Book
    case Misc
    case Other
    
    public var rawValue: String {
        switch self {
        case .Blood: return "blood"
        case .Oxygen: return "oxygen"
        case .Drug: return "drug"
        case .MedicalEquipment: return "medical_equipment"
        case .Grocery: return "grocery"
        case .Facility: return "facility"
        case .Subscription: return "subscription"
        case .Electronics: return "electronics"
        case .Clothing: return "clothing"
        case .Book: return "book"
        case .Misc: return "misc"
        case .Other: return "other"
        }
    }
    
}
