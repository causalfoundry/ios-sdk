//
//  ItemType.swift
//
//
//  Created by khushbu on 27/10/23.
//

import CasualFoundryCore
import Foundation

public enum ItemType: String, EnumComposable {
    case blood
    case oxygen
    case drug
    case medicalEquipment = "medical_equipment"
    case grocery
    case facility
    case electronics
    case clothing
    case book
    case misc
}
