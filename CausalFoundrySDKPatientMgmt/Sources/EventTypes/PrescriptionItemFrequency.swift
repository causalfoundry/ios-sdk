//
//  PrescriptionItemFrequency.swift
//
//
//  Created by khushbu on 03/11/23.
//

import CausalFoundrySDKCore
import Foundation

public enum PrescriptionItemFrequency: String, EnumComposable {
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
    case Other
    
    
    public var rawValue: String {
        switch self {
        case .AM: return "AM"
        case .PM: return "PM"
        case .OD: return "OD"
        case .BD: return "BD"
        case .TDS: return "TDS"
        case .QDS: return "QDS"
        case .OM: return "OM"
        case .ON: return "ON"
        case .CC: return "CC"
        case .PC: return "PC"
        case .AC: return "AC"
        case .PRN: return "PRN"
        case .Other: return "other"
        }
    }
    
}
