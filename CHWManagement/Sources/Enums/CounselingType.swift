//
//  CounselingType.swift
//
//
//  Created by khushbu on 21/11/23.
//

#if canImport(CasualFoundryCore)
import CasualFoundryCore
#endif
import Foundation

public enum CounselingType: String, Codable, EnumComposable {
    case lifestyle
    case psychological
    case other
}
