//
//  PrescriptionItemFrequency.swift
//
//
//  Created by khushbu on 03/11/23.
//

import CausalFoundrySDKCore
import Foundation

public enum PrescriptionItemFrequency: String, Codable, EnumComposable {
    case AM
    case PM
    case OD
    case BD
    case TDS
    case QDS
    case OM
    case ON
    case CC
    case PC
    case AC
    case PRN
    case other
}
