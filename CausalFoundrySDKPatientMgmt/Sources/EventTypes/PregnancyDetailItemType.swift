//
//  PregnancyDetailItemType.swift
//  
//
//  Created by MOIZ HASSAN KHAN on 26/4/24.
//

import CausalFoundrySDKCore
import Foundation

public enum PregnancyDetailItemType: String, EnumComposable {
    case Diabetes
    case Hypertension
    case AncStarted
    case FollowupInterest
    case IptDrugs
    case Supplements
    case MosquitoNet
    case GestationalAge
    case Temperature
    case EstimatedDeliveryDate
    case Other
    
    
    public var rawValue: String {
        switch self {
        case .Diabetes: return "diabetes"
        case .Hypertension: return "hypertension"
        case .AncStarted: return "anc_started"
        case .FollowupInterest: return "followup_interest"
        case .IptDrugs: return "ipt_drugs"
        case .Supplements: return "supplements"
        case .MosquitoNet: return "mosquito_net"
        case .GestationalAge: return "gestational_age"
        case .Temperature: return "temperature"
        case .EstimatedDeliveryDate: return "estimated_delivery_date"
        case .Other: return "other"
        }
    }
    
}
