//
//  PatientStatusValueType.swift
//
//
//  Created by khushbu on 04/11/23.
//

import Foundation
import CasualFoundryCore

public enum PatientStatusValueType: String, Codable,EnumComposable {
    case n_a
    case new_patient
    case known_patient
}
