//
//  ScreeningType.swift
//
//
//  Created by khushbu on 07/11/23.
//

import Foundation
import CasualFoundryCore


public enum ScreeningType: String,EnumComposable {
    case triage
    case outpatient
    case inpatient
    case pharmacy
    case doorToDoor = "door_to_door"
    case camp
    case other
}
