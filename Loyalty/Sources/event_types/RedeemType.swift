//
//  RedeemType.swift
//
//
//  Created by khushbu on 08/11/23.
//

import CausalFoundrySDKCore
import Foundation

public enum RedeemType: String, Codable, EnumComposable {
    case cash
    case airtime
    case other
}
