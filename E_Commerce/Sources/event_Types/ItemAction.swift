//
//  ItemAction.swift
//
//
//  Created by khushbu on 29/10/23.
//

import CasualFoundryCore
import Foundation

public enum ItemAction: String, EnumComposable {
    case impression
    case view
    case detail
    case add_favorite
    case remove_favorite
    case add_reminder
    case remove_reminder
    case remove_reminder_auto
}
