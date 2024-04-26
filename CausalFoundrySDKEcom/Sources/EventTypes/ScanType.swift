//
//  ScanType.swift
//
//
//  Created by khushbu on 01/11/23.
//

import CausalFoundrySDKCore
import Foundation

public enum ScanType: String, EnumComposable {
    case Pin
    case QrCode
    
    public var rawValue: String {
        switch self {
        case .Pin: return "pin"
        case .QrCode: return "qr_code"
        }
    }
}
