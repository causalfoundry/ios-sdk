//
//  DiagnosisType.swift
//
//
//  Created by khushbu on 03/11/23.
//

import CausalFoundrySDKCore
import Foundation

public enum DiagnosisType: String, EnumComposable {
    case bloodPressure = "blood_pressure"
    case bloodGlucose = "blood_glucose"
    case bmi
    case temperature
    case cvd
}
