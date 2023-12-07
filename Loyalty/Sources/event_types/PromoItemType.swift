//
//  PromoItemType.swift
//
//
//  Created by khushbu on 08/11/23.
//

#if canImport(CasualFoundryCore)
import CasualFoundryCore
#endif
import Foundation

public enum PromoItemType: String, Codable, EnumComposable {
    case blood
    case oxygen
    case drug
    case grocery
    case facility
    case electronics
    case clothing
    case book
    case misc
}
