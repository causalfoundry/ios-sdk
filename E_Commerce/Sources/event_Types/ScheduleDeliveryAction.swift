//
//  ScheduleDeliveryAction.swift
//
//
//  Created by khushbu on 01/11/23.
//

#if canImport(CasualFoundryCore)
import CasualFoundryCore
#endif
import Foundation

public enum ScheduleDeliveryAction: String, Codable, EnumComposable {
    case schedule
    case update
}
