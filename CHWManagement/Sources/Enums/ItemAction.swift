//
//  File.swift
//  
//
//  Created by khushbu on 26/10/23.
//

import Foundation
import CasualFoundryCore

public enum ItemAction: String, Codable,EnumComposable {
    case view
    case add
    case update
    case remove
}
