//
//  File 2.swift
//
//
//  Created by khushbu on 04/11/23.
//

#if canImport(CasualFoundryCore)
import CasualFoundryCore
#endif
import Foundation

public enum TreatmentFrequency: String, Codable, EnumComposable {
    case daily
    case days
    case weeks
    case months
}
