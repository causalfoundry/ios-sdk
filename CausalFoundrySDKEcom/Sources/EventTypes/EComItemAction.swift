//
//  ItemAction.swift
//
//
//  Created by khushbu on 29/10/23.
//

import CausalFoundrySDKCore
import Foundation

public enum EComItemAction: String, EnumComposable {
    case Impression
    case View
    case Detail
    case TopUp
    case Cancel
    case Update
    case Remove
    case Add
    case Select
    case AddFavorite
    case RemoveFavorite
    case AddReminder
    case RemoveReminder
    case RemoveReminderAuto
    case Other
    
    public var rawValue: String {
        switch self {
        case .Impression: return "impression"
        case .View: return "view"
        case .Detail: return "detail"
        case .TopUp: return "top_up"
        case .Cancel: return "cancel"
        case .Update: return "update"
        case .Remove: return "remove"
        case .Add: return "add"
        case .Select: return "select"
        case .AddFavorite: return "add_favorite"
        case .RemoveFavorite: return "remove_favorite"
        case .AddReminder: return "add_reminder"
        case .RemoveReminder: return "remove_reminder"
        case .RemoveReminderAuto: return "remove_reminder_auto"
        case .Other: return "other"
        }
    }
    
}
