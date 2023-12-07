//
//  CartAction.swift
//
//
//  Created by khushbu on 01/11/23.
//

#if canImport(CasualFoundryCore)
import CasualFoundryCore
#endif
import Foundation

public enum CartAction: String, Codable, EnumComposable {
    case add_item
    case remove_item
}
