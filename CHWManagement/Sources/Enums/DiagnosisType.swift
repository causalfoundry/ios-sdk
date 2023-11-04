//
//  DiagnosisType.swift
//
//
//  Created by khushbu on 03/11/23.
//

import Foundation
import CasualFoundryCore


public enum DiagnosisType: String, Codable,EnumComposable {
    case bloodPressure = "blood_pressure"
    case bloodGlucose = "blood_glucose"
    case bmi
    case temperature
    case cvd
}
