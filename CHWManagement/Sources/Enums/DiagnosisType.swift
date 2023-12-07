//
//  DiagnosisType.swift
//
//
//  Created by khushbu on 03/11/23.
//

#if canImport(CasualFoundryCore)
import CasualFoundryCore
#endif
import Foundation

public enum DiagnosisType: String, Codable, EnumComposable {
    case bloodPressure = "blood_pressure"
    case bloodGlucose = "blood_glucose"
    case bmi
    case temperature
    case cvd
}
