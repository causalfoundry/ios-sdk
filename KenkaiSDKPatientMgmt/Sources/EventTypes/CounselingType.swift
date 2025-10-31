//
//  CounselingType.swift
//
//
//  Created by khushbu on 21/11/23.
//

import KenkaiSDKCore
import Foundation

public enum CounselingType: String, EnumComposable {
    case Lifestyle
    case Psychological
    case Other
    
    public var rawValue: String {
        switch self {
        case .Lifestyle: return "lifestyle"
        case .Psychological: return "psychological"
        case .Other: return "other"
        }
    }
    
}
