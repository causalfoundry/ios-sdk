//
//  ItemAction.swift
//
//
//  Created by khushbu on 26/10/23.
//

#if canImport(CasualFoundryCore)
import CasualFoundryCore
#endif
import Foundation

public enum ItemAction: String, Codable, EnumComposable {
    case view
    case add
    case update
    case remove
}
