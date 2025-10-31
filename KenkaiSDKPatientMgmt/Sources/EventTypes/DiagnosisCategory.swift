//
//  File.swift
//  
//
//  Created by MOIZ HASSAN KHAN on 30/8/24.
//

import Foundation
import KenkaiSDKCore

public enum DiagnosisCategory: String, EnumComposable {

    case Computed
    case Given
    case Other
    
    
    public var rawValue: String {
        switch self {
        case .Computed: return "computed"
        case .Given: return "given"
        case .Other: return "other"
        }
    }
    
}

