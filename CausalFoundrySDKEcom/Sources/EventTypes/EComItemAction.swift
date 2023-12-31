//
//  ItemAction.swift
//
//
//  Created by khushbu on 29/10/23.
//

import CausalFoundrySDKCore
import Foundation

public enum EComItemAction: String, EnumComposable {
    case impression
    case view
    case detail
    case add_favorite
    case remove_favorite
    case add_reminder
    case remove_reminder
    case remove_reminder_auto
    case top_up
    case cancel
    case update
    case remove
    case add
    case select
}
