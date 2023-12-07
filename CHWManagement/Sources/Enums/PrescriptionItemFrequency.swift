//
//  PrescriptionItemFrequency.swift
//
//
//  Created by khushbu on 03/11/23.
//

#if canImport(CasualFoundryCore)
import CasualFoundryCore
#endif
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
