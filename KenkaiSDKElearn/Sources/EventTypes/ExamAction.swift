//
//  ExamAction.swift
//
//
//  Created by moizhassankh on 04/01/24.
//
import KenkaiSDKCore
import Foundation

public enum ExamAction: String, EnumComposable {
    case Start
    case Submit
    case Result
    case Other
    
    public var rawValue: String {
        switch self {
        case .Start: return "start"
        case .Submit: return "submit"
        case .Result: return "result"
        case .Other: return "other"
        }
    }
    
}
