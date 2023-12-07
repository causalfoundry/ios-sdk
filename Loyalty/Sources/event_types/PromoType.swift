//
//  PromoType.swift
//
//
//  Created by khushbu on 07/11/23.
//

#if canImport(CasualFoundryCore)
import CasualFoundryCore
#endif
import Foundation

public enum PromoType: String, EnumComposable {
    case add_to_cart
    case coupon
}
