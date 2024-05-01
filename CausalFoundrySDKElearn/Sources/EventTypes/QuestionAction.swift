//
//  QuestionAction.swift
//
//
//  Created by moizhassankh on 04/01/24.
//

import CausalFoundrySDKCore

import Foundation

public enum QuestionAction: String, EnumComposable {
    case Answer
    case Skip
    case Other
    
    
    public var rawValue: String {
        switch self {
        case .Answer: return "answer"
        case .Skip: return "skip"
        case .Other: return "other"
        }
    }
}
