//
//  ScanChannel.swift
//
//
//  Created by khushbu on 01/11/23.
//

#if canImport(CasualFoundryCore)
import CasualFoundryCore
#endif
import Foundation

public enum ScanChannel: String, Codable, EnumComposable {
    case app
    case ussd
}
