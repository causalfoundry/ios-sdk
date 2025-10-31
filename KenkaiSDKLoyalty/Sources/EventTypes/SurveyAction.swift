//
//  SurveyAction.swift
//
//
//  Created by khushbu on 08/11/23.
//

import KenkaiSDKCore
import Foundation

public enum SurveyAction: String, EnumComposable {
    case View
    case Impression
    case Start
    case Submit
    case Other
    
    public var rawValue: String {
        switch self {
        case .View: return "view"
        case .Impression: return "impression"
        case .Start: return "start"
        case .Submit: return "submit"
        case .Other: return "other"
        }
    }
    
}
