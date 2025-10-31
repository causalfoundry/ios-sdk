//
//  MilestoneAction.swift
//
//
//  Created by khushbu on 07/11/23.
//

import KenkaiSDKCore
import Foundation

public enum MilestoneAction: String, EnumComposable {
    case Achieved
    case Other
    
    public var rawValue: String {
        switch self {
        case .Achieved: return "achieved"
        case .Other: return "other"
        }
    }
}
