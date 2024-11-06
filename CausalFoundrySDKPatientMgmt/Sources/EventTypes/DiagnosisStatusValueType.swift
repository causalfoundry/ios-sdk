//
//  DiagnosisStatusValueType.swift
//  CausalFoundrySDK
//
//  Created by MOIZ HASSAN KHAN on 6/11/24.
//

import CausalFoundrySDKCore
import Foundation

public enum DiagnosisStatusValueType: String, EnumComposable {
    case Positive
    case Negative
    case Recovered
    case NA
    case Unknown
    case Other
    
    public var rawValue: String {
        switch self {
        case .Positive: return "positive"
        case .Negative: return "negative"
        case .Recovered: return "recovered"
        case .NA: return "n_a"
        case .Unknown: return "unknown"
        case .Other: return "other"
        }
    }
}
