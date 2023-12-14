//
//  CancelType.swift
//
//
//  Created by khushbu on 01/11/23.
//

#if canImport(CasualFoundryCore)
import CasualFoundryCore
#endif
import Foundation

public enum CancelType: String, Codable, EnumComposable {
    case cart
    case order
}
