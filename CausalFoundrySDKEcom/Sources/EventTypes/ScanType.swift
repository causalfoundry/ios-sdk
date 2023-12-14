//
//  ScanType.swift
//
//
//  Created by khushbu on 01/11/23.
//

import CausalFoundrySDKCore
import Foundation

public enum ScanType: String, Codable, EnumComposable {
    case pin
    case qr_code
}
