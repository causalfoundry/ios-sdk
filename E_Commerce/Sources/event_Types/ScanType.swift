//
//  ScanType.swift
//
//
//  Created by khushbu on 01/11/23.
//

#if canImport(CasualFoundryCore)
import CasualFoundryCore
#endif
import Foundation

public enum ScanType: String, Codable, EnumComposable {
    case pin
    case qr_code
}
