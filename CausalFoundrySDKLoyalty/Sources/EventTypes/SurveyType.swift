//
//  SurveyType.swift
//
//
//  Created by khushbu on 08/11/23.
//

import CausalFoundrySDKCore
import Foundation

public enum SurveyType: String, EnumComposable {
    case OpenEnded
    case ClosedEnded
    case Nominal
    case LikertScale
    case RatingScale
    case YesNo
    case Interview
    case Other
    
    
    public var rawValue: String {
        switch self {
        case .OpenEnded: return "open_ended"
        case .ClosedEnded: return "closed_ended"
        case .Nominal: return "nominal"
        case .LikertScale: return "likert_scale"
        case .RatingScale: return "rating_scale"
        case .YesNo: return "yes_no"
        case .Interview: return "interview"
        case .Other: return "other"
        }
    }
    
}
