//
//  ExamAction.swift
//
//
//  Created by khushbu on 02/11/23.
//
#if canImport(CasualFoundryCore)
import CasualFoundryCore
#endif
import Foundation

public enum ExamAction: String, EnumComposable {
    case start
    case submit
    case result
}
