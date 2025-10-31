//
//  File.swift
//  
//
//  Created by MOIZ HASSAN KHAN on 2/9/24.
//

import KenkaiSDKCore
import Foundation

public enum DiagnosisStatusRiskType: String, EnumComposable {
    case Low
    case High
    case NA
    case Unknown
    case Other
    
    public var rawValue: String {
        switch self {
        case .Low: return "low"
        case .High: return "high"
        case .NA: return "n_a"
        case .Unknown: return "unknown"
        case .Other: return "other"
        }
    }
    
}
