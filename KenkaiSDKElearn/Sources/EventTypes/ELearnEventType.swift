//
//  ELearnEventType.swift
//
//
//  Created by moizhassankh on 04/01/24.
//

import Foundation

public enum ELearnEventType: String, CaseIterable, Codable {
    case Module
    case Exam
    case Question
    
    public var rawValue: String {
        switch self {
        case .Module: return "module"
        case .Exam: return "exam"
        case .Question: return "question"
        }
    }
    
}
