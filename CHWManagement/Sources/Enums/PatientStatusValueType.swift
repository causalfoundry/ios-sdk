//
//  PatientStatusValueType.swift
//
//
//  Created by khushbu on 04/11/23.
//

#if canImport(CasualFoundryCore)
import CasualFoundryCore
#endif
import Foundation

public enum PatientStatusValueType: String, Codable, EnumComposable {
    case n_a
    case new_patient
    case known_patient
}
