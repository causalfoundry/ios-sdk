//
//  PatientMgmtEventType.swift
//
//
//  Created by khushbu on 25/10/23.
//

import Foundation

public enum PatientMgmtEventType: String, CaseIterable {
    
    case ModuleSelection
    case Patient
    case Encounter
    case Appointment

    public var rawValue: String {
        switch self {
        case .ModuleSelection: return "module_selection"
        case .Patient: return "patient"
        case .Encounter: return "encounter"
        case .Appointment: return "appointment"
        }
    }
}
