//
//  DiagnosisSymptomType.swift
//
//
//  Created by khushbu on 03/11/23.
//

#if canImport(CasualFoundryCore)
import CasualFoundryCore
#endif
import Foundation

public enum DiagnosisSymptomType: String, Codable, EnumComposable {
    case diabetes
    case hypertension
}
