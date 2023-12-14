//
//  TreatmentType.swift
//
//
//  Created by khushbu on 04/11/23.
//

import CausalFoundrySDKCore
import Foundation

public enum TreatmentType: String, Codable, EnumComposable {
    case medical_review
    case blood_pressure
    case blood_glucose
    case HbA1c
}
