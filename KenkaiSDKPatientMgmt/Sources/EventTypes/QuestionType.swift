//
//  QuestionType.swift
//
//
//  Created by MOIZ HASSAN KHAN on 26/4/24.
//

import KenkaiSDKCore
import Foundation

public enum QuestionType: String, EnumComposable {
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
