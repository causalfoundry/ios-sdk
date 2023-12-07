//
//  RewardAction.swift
//
//
//  Created by khushbu on 07/11/23.
//

#if canImport(CasualFoundryCore)
import CasualFoundryCore
#endif
import Foundation

public enum RewardAction: String, EnumComposable {
    case view
    case add
    case redeem
}
