//
//  ShopMode.swift
//
//
//  Created by khushbu on 02/11/23.
//

#if canImport(CasualFoundryCore)
import CasualFoundryCore
#endif
import Foundation

public enum ShopMode: String, Codable, EnumComposable {
    case delivery
    case pickup
}
