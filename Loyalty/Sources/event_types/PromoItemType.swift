//
//  PromoItemType.swift
//
//
//  Created by khushbu on 08/11/23.
//

import CasualFoundryCore
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
