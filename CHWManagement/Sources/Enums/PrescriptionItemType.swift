//
//  PrescriptionItemType.swift
//  
//
//  Created by khushbu on 03/11/23.
//

import Foundation
import CasualFoundryCore


import Foundation

public enum PrescriptionItemType: String, Codable,EnumComposable {
    case tablet
    case capsule
    case syrup
    case injection
    case insulin
    case other
}

